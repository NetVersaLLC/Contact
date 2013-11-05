#!/usr/bin/env perl

package Payload;
use Data::Dumper qw/Dumper/;

sub new($$$$$) {
  my $pkg     = shift;
  my $mode_id = shift;
  my $site_id = shift;
  my $id      = shift;
  my $name    = shift;
  my $active  = shift;
  my $self = bless({
    'mode_id' => $mode_id,
    'site_id' => $site_id,
    'id'      => $id,
    'name'    => $name,
    'active'  => $active,
    'parent'  => undef
  }, $pkg);
  return $self;
}

sub set_payload($$$$$) {
  my $payloads = shift;
  my $mode_id  = shift;
  my $site_id  = shift;
  my $id       = shift;
  my $payload  = shift;
  if (not exists($payloads->{$mode_id})) {
    $payloads->{$mode_id} = {};
  }
  if (not exists($payloads->{$mode_id}->{$site_id})) {
    $payloads->{$mode_id}->{$site_id} = {};
  }
  $payloads->{$mode_id}->{$site_id}->{$id} = $payload;
}

sub calculate_children($) {
  my $payloads = shift;
  my %children;
  foreach my $payload (keys %$payloads) {
    if (not exists $children{$payload->{'parent'}->{'id'}}) {
      $children{$payload->{'parent'}->{'id'}} = [$payload];
    } else {
      push @{$children{$payload->{'parent'}->{'id'}}}, $payload;
    }
  }
  foreach my $child (keys %children) {
    my $payload = $$payloads{$child};
    $$payload{'children'} = $children{$child};
  }
}

sub load($) {
  my $rows = shift;
  print Dumper($rows), "\n";
  my ($row, %payloads);
  foreach $row (@$rows) {
    my $parent_id = shift @$row;
    my ($mode_id, $site_id, $id) = @$row;
    my $payload = new Payload(@$row);
    $$payload{'parent'} = $payloads{$parent_id};
    $payloads{$row->[0]} = $payload;
    &Payload::set_payload(\%payloads, $mode_id, $site_id, $id, $payload);
  }
  &calculate_children(\%payloads);
  return \%payloads;
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

my ($payloads, %packages, $business_id);

$payloads_sth = $dbh->prepare("SELECT parent_id, mode_id, site_id, id, name, active FROM payloads");
$payloads_sth->execute();
$payloads = &Payload::load($payloads_sth->fetchall_arrayref());
$payloads_sth->finish();

$packages_sth = $dbh->prepare("SELECT package_id, site_id FROM package_payloads");
$packages_sth->execute();
foreach my $package (@{$packages_sth->fetchall_arrayref()}) {
  if (not exists $packages{$package->[0]}) {
    $packages{$package->[0]}=[$package->[1]];
  } else {
    push @{$packages{$package->[0]}}, $package->[1];
  }
}
$packages_sth->finish();

print Dumper($payloads), "\n";

__END__
$business_sth = $dbh->prepare("SELECT business.id, business.mode_id, subscription.package_id FROM businesses business INNER JOIN subscriptions subscription WHERE business.subscription_id = subscription.id AND subscription.active=1");
$business_sth->execute();
foreach $business (@{$business_sth->fetchall_arrayref()}) {
  my ($business_id, $mode_id, $package_id) = @$business;
  if (not exists $packages{$package_id}) {
    print "Invalid package_id $package_id for $business_id\n";
    next;
  }
  foreach my $site_id (@{$packages{$package_id}}) {
    &Payload::examine($mode_id, $site_id, $business_id);
  }
}
$business_sth->finish();
