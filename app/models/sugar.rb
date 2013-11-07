class Sugar

  def initialize(url, username, password)
    @url = url
    @username = username
    @password = password
  end

  def generate_lead( business_name, first_name, last_name, phone, email, zip, referral, package, ident, label)

      sales_person = connection::User.all( {conditions: { user_name: "LIKE '%#{referral}'"}} ).first
      lead = connection::Lead.new

      lead.account_name = business_name
      lead.first_name = first_name
      lead.last_name = last_name
      lead.email1 = email
      lead.phone_work = phone
      lead.primary_address_postalcode = zip
      lead.opportunity_amount = "#{package.price} - #{package.monthly_fee}/month"
      lead.refered_by = "#{label.name} - #{referral}"
      lead.lead_source_description = "report id=#{ident} - package id=#{package.id}"

      lead.assigned_user_id = sales_person.id if sales_person

      lead.save
  end

  private
    def connection
      @sugar_connection ||= SugarCRM::connect( @url, @username, @password )
    end
end 
