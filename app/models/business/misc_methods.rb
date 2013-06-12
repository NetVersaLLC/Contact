module Business::MiscMethods
  extend ActiveSupport::Concern
  included do

    def set_times
      ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'].each do |day|
        self.send "#{day}_open=", '08:30AM' if self.send("#{day}_open") == nil
        self.send "#{day}_close=", '05:30PM'  if self.send("#{day}_close") == nil
      end
    end

    def checkin
      self.client_checkin = Time.now
      save
    end

    def create_jobs
      sub = self.subscription
      PackagePayload.where(:package_id => sub.package_id).each do |obj|
        payload  = Payload.new( obj.site, obj.payload )
        job      = Job.inject(self.id, payload.payload, payload.data_generator, payload.ready)
        job.name = "#{obj.site}/#{obj.payload}"
        job.save
      end
    end

    def birthday
      if self.contact_birthday
        Date.strptime self.contact_birthday, '%m/%d/%Y'
      else
        Date.today - 30.year - (rand()*365).day
      end
    end


    def report_xlsx
      account_data, non_account_data = payload_status_data()
      p = Axlsx::Package.new

      accounts = p.workbook.add_worksheet(:name => "AccountInfo")
      account_data.each do |row|      
        accounts.add_row row
      end

      non_accounts = p.workbook.add_worksheet(:name => "NonAccountStatus") 
      non_account_data.each do |row|      
        non_accounts.add_row row
      end

      c='abcdefghijklmnopqrstuvwxyz'
      setup = ''
      1.upto(10) do |i|
        setup += c[rand() * 26]
      end
      tmp_file = Rails.root.join('tmp', "#{setup}.xlsx")
      # for iWork numbers 
      p.use_shared_strings = true
      p.serialize(tmp_file)
      tmp_file
    end

    def payload_status_data
      account_data = [ ['Site', 'Username', 'Passord','Other'] ]
      non_account_sites = [] 
      non_account_data = [ ['Site', 'Status'] ]

      citation_site_hash = Business.site_accounts_by_key2
      PackagePayload.where(:package_id => self.subscription.package_id).each do |p|
        site = citation_site_hash[p.site]

        if site.nil?
          non_account_data.push [p.site, 'Name not on citation list']
          next
        end
        
        if self.respond_to?(site[1]) and self.send(site[1]).count > 0
          self.send(site[1]).each do |thing|
            row = ['','','','']
            row[0] = site[3].to_s

            username = thing.username if thing.respond_to?('username') 
            username ||= thing.email if thing.respond_to?('email') 
            username ||= 'submitted' 
            password = thing.password if thing.respond_to?('password') 
            password ||= '' 
            row[1] = username.to_s
            row[2] = password.to_s 

            other_fields = []
            site[2].each do |name|
              next if %w(email username password).include?(name[1])

              if name[0] == 'text'
                other_fields.push thing.send(name[1]).to_s
              end
            end
            row[3] = other_fields.join(',')

            account_data.push row
          end         

        else
          non_account_sites.push site[0]
        end
      end

      job_status_hash = completed_failed_job_hash()
      non_account_sites.each do |site|
        job_status_hash[site] ||= 'Submitted'
        non_account_data.push [site, job_status_hash[site] ] 
      end

      return [account_data, non_account_data]
    end

    def completed_failed_job_hash
      hash = {}
      CompletedJob.where(:business_id => self.id).each do |row|
        hash[row.name.split("/")[0]] = 'Completed'
      end

      FailedJob.where(:business_id => self.id).each do |row|
        hash[row.name.split("/")[0]] = 'Failed'
      end

      return hash
    end

  end
end
