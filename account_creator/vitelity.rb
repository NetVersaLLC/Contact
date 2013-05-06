#!/usr/bin/env ruby
# encoding: utf-8

require 'rest_client'
require 'awesome_print'
require 'active_support/core_ext/hash/conversions'

class Vitelity

  def commands
  {"balance"=>"reports back your current account balance",
   "cdrlist"=> "Gives all NEW CDR records and keeps track of which ones you have VS. which ones you do not. Can only be ran in 5 minute intervals",
   "resetcdrlist"=> "Reset CDR records for the cdrlist API command (you cannot undo this)",
   "didcdrdetail"=> "Give the seconds of use and cost for a specific did for a timeframe",
   "subaccountcdrdetail"=> "Pull details records for a specific sub account for a date range",
   "listtollfree"=> "lists all Toll Free Numbers that are available for immediate order",
   "listlocal"=>"lists all local DID numbers currently in stock",
   "listnpanxx"=>"lists all available local numbers with a specific NPANXX",
   "listratecenters"=> "lists all of the ratecenters available for a specific state",
   "listavailratecenters"=> "lists all ratecenters that we currently have in stock",
   "searchtoll"=> "searches the SMS/800 database for a specific vanity number or numbers",
   "listavailstates"=> "lists all states that have DIDs which are currently in stock",
   "liststates"=>"Lists all available DID states line by line",
   "listdids"=>"lists all current Local and Toll free DIDs",
   "didnote"=>"Add note to DID for future reference",
   "listintlratecenters"=> "Lists all international ratecenters for a specific country",
   "listintl"=>"Lists all countries supported for International DIDs",
   "getdidnote"=>"Get the current DID note set for a specific DID",
   "listspecificlocal"=> "Lists the rates assocated with a specific and Available DID number",
   "listnpa"=> "lists all available local numbers with a specific NPA / Area code",
   "lidb"=>"Set the CallerID Name for a specific number (LIDB / CNAM)",
   "lidbavailall"=> "List all numbers where LIDB / CallerID / CNAM name change is available",
   "getbackorder"=> "Get the status of a DID backorder to tell if it's been filled",
   "gettollfree"=>"Orders a specific toll free number in our available list",
   "getlocaldid"=>"orders a specific local number in our available list",
   "removedid"=>"Remove a currently assigned DID number",
   "requestvanity"=> "orders a specific toll free number from the SMS800 available pool",
   "localbackorder"=> "back orders a specific ratecenter/state that is not in stock",
   "getintldid"=> "Orders a specific international DID based on ratecenter/country",
   "localbackorderrate"=>"Get rate for backordering a ratecenter",
   "didforcebilling"=> "Force the billing for a specific DID to a certain sub account",
   "e911send"=>"Input or update new 911 address for a specific DID number",
   "e911delete"=>"Delete a registered 911 address from a specific DID",
   "e911checkaddress"=>"Check eligibility of a specific address for 911 service",
   "e911getinfo"=>"Get 911 information on a specific DID Number",
   "listincomingfaxes"=>"Lists all incoming faxes",
   "getfax"=>"Retrieve a specific fax from our system",
   "sentfaxstatus"=>"Lists all or specific info on sent faxes",
   "sendfax"=>"Allows you to send a fax over the API",
   "faxlistdids"=>"List vfax DID numbers available for purchase",
   "faxgetdid"=>"Order a specific vfax DID number to your account",
   "faxlistratecenters"=> "Lists all of the available rate centers for a specific state line by line",
   "faxliststates"=>"Lists all of the available states line by line",
   "faxchangeemail"=> "Changes email addresses assigned to a vFax DID (new faxes are emailed here)",
   "newfaxacc"=> "Creates new vFax account for use with viewmyfax.com/faxcentral.net",
   "setfaxacc"=>"Set DIDs associated to vFax account",
   "allowdidchangeemail"=> "This option allows end user to modify the email addresses faxes are sent to when they receive a fax",
   "allowoutchangeemail"=> "Allows user to update the email addresses for sending out faxes to number@emailyourfax.com.",
   "increasecredits"=> "Increases the number of DIDs a specific vFax account is allowed to order. ",
   "setcredits"=> "Set the number of DIDs a vfax account can order through viewmyfax portal",
   "getcredits"=>
  "Return how many DID order credits a customer has remaining on a vfax account",
    "setlimit"=>
  "Set the number of daily outbound faxes a specific vFax account can send per day",
    "faxlistmydids"=>"Return a full list of your vfax numbers",
    "delfaxacc"=>"Remove existing vFax account",
 "addport"=>"Add LNP order",
 "uploadsignature"=>
  "Upload Signature for LNP order if required. Must be 225 pixels by 50 pixels in size, in JPG, GIF, PNG or BMP format.",
 "uploadbill"=>
  "Upload Bill for LNP order if required. Bill copy must be in PDF or JPG formats. PDF Recommended.",
 "checkavail"=>"Check LNP Availability for DID Number",
 "checkmultiavail"=>
  "Check LNP Availability for multiple DID Numbers at once. Will respond with number:support. (support may be voice, both or nosupport) Both means Voice & vFax.",
 "callfromclick"=>
  "Sends someone a phone call that then connects them to customer service/another number.",
 "reroute"=>"changes the sub account or IP that the DID routes to",
 "routeall"=>
  "Changes routing for ALL of your DID numbers to a specific IP or sub account",
 "getrate"=>
  "Gets a rate on a specific domestic or International call (ex:011-number or 1-number)",
 "subaccounts"=>"Lists all sub accounts",
 "failover"=>"Set fail over for a specific DID number",
 "callfw"=>"Set call forwarding for specific DID",
 "newvoicemail"=>
  "New voicemail account - Allows you to create a new voicemail account",
 "resetvoicemail"=>"Reset voicemail password for specific account",
 "listvoicemails"=>"List all voicemail accounts",
 "addvoicemailtodid"=>"Link a voicemail account to a did number ",
 "cnamenable"=>"Enable CNAM Services on a specific DID",
 "cnamdisable"=>"Disable CNAM on a specific DID number",
 "cnamstatus"=>
  "Check whether CNAM is disabled or enabled on a specific DID Number",
 "addsubacc"=>"Add a sub account or SIP peer to your account",
 "delsubacc"=>
  "Delete a SIP Peer or Sub Account from your account (irreversible)",
 "lidbavail"=>
  "Verify availability of CallerID name on a specific DID (only works on limited DID numbers)",
 "lidbcheck"=>"Give status of a lidb request",
 "remvoicemail"=>"Delete voicemail account",
 "migratedids"=>"Migrate DID Numbers from one sub account to another",
 "massreroute"=>"changes the sub account or IP that multiple DIDs routes to",
 "checksms"=>"Check availability of SMS on a specific DID",
 "removesms"=>"Remove SMS from a specific DID number",
 "smsdids"=>"List all DIDs that you OWN and have SMS functionality available",
 "smsenableurl"=>
  "Set the URL for SMS messages to be delivered to for SMS+http enabled DIDs",
 "sendsms"=>"Send an SMS message from an SMS enabled DID number",
 "setsms"=>"Enable SMS functionality on a specific DID",
 "smsenablehtt"=>
  "Enable SMS functionality on a specific DID and sends via an HTTPD request. Will POST the variables: $msgid, $src, $dst and $msg to your URL.",
 "sendshort"=>"Send Short Code SMS messages over API",
 "cnam"=>"looks up the specific caller id name for a specific number",
 "npanxxlookup"=>"Lookup Ratecenter & State name in LERG format"}
  end

  def initialize(u,p)
    @username = u
    @password = p
  end

  def method_missing(*args)
    options = {
      :login => @username,
      :pass  => @password,
      :cmd   => args.shift,
      :xml   => :yes
    }
    unless self.commands[ options[:cmd].to_s ]
      raise "Invalid API Command: #{options[:cmd]}"
    end

    if args[0].is_a? Hash
      options.merge!(args[0])
    end
    res = RestClient.post("http://api.vitelity.net/api.php", options)
    if res
      return Hash.from_xml(res)
    else
      raise "No data!"
    end
  end
end
