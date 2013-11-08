class Sugar

  def initialize(url, username, password)
    @url = url
    @username = username
    @password = password
  end

  def generate_lead( business_name, first_name, last_name, phone, email, zip, referral, package, ident, label)

    sales_person = connection::User.all( {conditions: { user_name: "LIKE '%#{referral}'"}} ).first

    lead = connection::Lead.all({conditions: { phone_work: phone} }).first
   
    if lead.nil?
      lead = connection::Lead.new

      lead.account_name = business_name
      lead.first_name = first_name
      lead.last_name = last_name
      lead.email1 = email
      lead.phone_work = phone
      lead.primary_address_postalcode = zip
      lead.opportunity_amount = "#{package.price} - #{package.monthly_fee}/month"
      lead.refered_by = "#{label.name} - #{referral}"
      lead.assigned_user_id = sales_person.id if sales_person

      lead.save
    end

    history = connection::Note.new
    history.assigned_user_id = sales_person.id if sales_person 
    history.name = "Scan Report Requested" 
    history.description = "https://sync.fastrank.net/scan/#{ident}"
    history.parent_type = "Leads" 
    history.parent_id = lead.id 
    history.save
  end

  private
    def connection
      @sugar_connection ||= SugarCRM::connect( @url, @username, @password )
    end
end 
