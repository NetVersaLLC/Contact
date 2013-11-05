#!/usr/bin/env perl

package Payload;
use Data::Dumper qw/Dumper/;
use Tree::Nary;

sub new($$) {
  my $pkg     = shift;
  my $dbh     = shift;
  my $jobs_sth = $dbh->prepare("SELECT site_id FROM jobs WHERE business_id=?");
  my $completed_sth = $dbh->prepare("SELECT site_id FROM completed_jobs WHERE business_id=?");
  my $self = bless({
      'tree' => Tree::Nary->new(),
      'dbh'  => $dbh,
      'completed_sth' => $completed_sth,
      'jobs_sth' => $jobs_sth
  }, $pkg);
  return $self;
}

sub add_payload($) {
  my $self = shift;
  my $payload = shift;
  $payload->{'children'} = $self->{'children'}->{$payload->{'id'}};
  if (length(@{$payload->{'children'}}) > 0) {
    foreach my $child (@{$payload->{'children'}}) {
      $self->add_payload($child);
    }
  }
}

sub build($) {
  my $self = shift;
  my $rows = shift;
  my $actives = shift;
  my (%payloads, %children, %parents, %tree);

  # Build indexes for the data
  # First create a mapping of id -> HASH
  foreach my $row (@$rows) {
    my ($parent_id, $mode_id, $site_id, $id, $name, $active) = @$row;
    next if not exists $actives->{$site_id}; # Skip sites not active
    $payloads{$id} = { 'id' => $id, 'mode_id' => $mode_id, 'site_id' => $site_id, 'name' => $name, 'active' => $active, 'parent_id' => $parent_id};
  }

  # Now build indexes for child / parent relationships
  foreach my $row (@$rows) {
    my ($parent_id, $mode_id, $site_id, $id, $name, $active) = @$row;
    next if not exists $actives->{$site_id}; # Skip sites not active
    $parent_id = $parent_id || 'root';
    $children{$parent_id} = [] unless exists $children{$parent_id};
    push @{$children{$parent_id}}, $payloads{$id};
    $parents{$id} = $parent_id || 'root';
  }
  $$self{'parents'}  = \%parents;
  $$self{'children'} = \%children;
  $$self{'payloads'} = \%payloads;

  # Now recursively add children to each node starting at the root nodes
  # Working on all sites/modes since each root is independent.
  foreach my $payload (@{$children{'root'}}) {
    $self->add_payload($payload);
  }

  # Now finally build the tree structure into $final
  my $final = {};
  foreach my $row (@$rows) {
    my ($parent_id, $mode_id, $site_id, $id, $name, $active) = @$row;
    next if $parents{$id} ne 'root'; # We are linking in the top level of the tree so only work on root nodes
    next if not exists $actives->{$site_id}; # Skip sites not active
    if (not exists($final->{$mode_id})) {
      $final->{$mode_id} = {};
    }
    if (not exists($final->{$mode_id}->{$site_id})) {
      $final->{$mode_id}->{$site_id} = {};
    }
    $final->{$mode_id}->{$site_id}->{$id} = $payloads{$id};
  }
  $$self{'tree'} = $final;
  return $self;
}

sub load($$) {
  my $dbh = shift;
  my $active = shift;
  $payloads_sth = $dbh->prepare("SELECT parent_id, mode_id, site_id, id, name, active FROM payloads");
  $payloads_sth->execute();
  my $rows = $payloads_sth->fetchall_arrayref();
  my $payloads = Payload->new($dbh);
  return $payloads->build($rows, $active);

sub recurse($$$$$) {
  my $self = shift;
  my $business_id = shift;
  my $payload_id = shift;
  my $completed = shift;
  my $queue = shift;
  my $payload = $self->{'payloads'}->{$payload_id};
  if (length $payload->{'children'} > 0) {
  }
}

sub examine($) {
  my $self = shift;
  my $mode_id = shift;
  my $site_id = shift;
  my $business_id = shift;
  my $jobs_sth = $self->{'jobs_sth'};
  my $completed_sth = $self->{'completed_sth'};
  my $tree = $self->{'tree'};
  my (%completed, %queue);
  $jobs_sth->execute($business_id);
  foreach my $payload_id ($jobs_sth->fetchrow_array) {
    $queue{$payload_id} = 'yes';
  }
  foreach my $payload_id ($completed_sth->fetchrow_array) {
    $completed{$payload_id} = 'yes';
  }
  foreach my $root_id (sort {int($a) <=> int($b)} keys %{ $tree->{$mode_id}->{$site_id} }) {
    $self->recurse($business_id, $root_id, \%completed, \%queue);
  }
}

package main;
use strict;
use DBI;
use YAML::Tiny;
use Data::Dumper qw/Dumper/;

#######################################################################
##    Welcome to the Fulfillment Nurse v2 High Speed Perl Edition    ##
#######################################################################

my ($config, $environment, $dbh);

$config = YAML::Tiny->read("config/database.yml");
$environment = $ENV{'RAILS_ENV'} || 'development';
$config = $config->[0]->{$environment};

$dbh = DBI->connect("dbi:mysql:$config->{'database'}", $config->{'username'}, $config->{'password'});

my ($business_sth, $payloads_sth, $packages_sth);

my ($payloads, %packages, %active, $business_id);

$packages_sth = $dbh->prepare("SELECT package.id, pa.site_id FROM package_payloads pa INNER JOIN packages package ON package.id=pa.package_id");
$packages_sth->execute();
foreach my $package (@{$packages_sth->fetchall_arrayref()}) {
  $active{$package->[1]} = 'yes';
  if (not exists $packages{$package->[0]}) {
    $packages{$package->[0]}=[$package->[1]];
  } else {
    push @{$packages{$package->[0]}}, $package->[1];
  }
}
$packages_sth->finish();
$payloads = &Payload::load($dbh, \%active);

$business_sth = $dbh->prepare("SELECT business.id, business.mode_id, subscription.package_id FROM businesses business INNER JOIN subscriptions subscription WHERE business.subscription_id = subscription.id AND subscription.active=1");
$business_sth->execute();
foreach my $business (@{$business_sth->fetchall_arrayref()}) {
  my ($business_id, $mode_id, $package_id) = @$business;
  if (not exists $packages{$package_id}) {
    print "Invalid package_id $package_id for $business_id\n";
    next;
  }
  foreach my $site_id (@{$packages{$package_id}}) {
    $payloads->examine($mode_id, $site_id, $business_id);
  }
}
$business_sth->finish();
