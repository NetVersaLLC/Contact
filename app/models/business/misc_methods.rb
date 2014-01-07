module Business::MiscMethods
  extend ActiveSupport::Concern
  included do
    def self.get_site(model, business)
      res = model.where(:business_id => business).first
      if res == nil
        res = model.create do |obj|
          obj.business_id = business.id
        end
      end
      res
    end

    def get_site(model)
      Business.get_site(model, self)
    end

    def logo
        images.where(:is_logo=>true).first
    end

    def label_id
      self.user.label_id
    end

    def strip_blanks
      self.attributes.each do |key,val|
        if val.class == String
          val.strip!
        end
      end
    end

    def paused?
      self.paused_at.present? 
    end

    def stopped?
      self.paused_at.present? || !self.categorized || !valid?
    end 

    def stopped_because
      a = []
      a << "paused at #{self.paused_at}" if paused?
      a << "has not been categorized" if !categorized
      a << "does not validate" if !valid?

      if a.empty?
        nil
      else 
        "Business " + a.to_sentence
      end 
    end 


    def add_job(name)
      p = Payload.by_name(name)
      job = Job.inject(self.id, p.client_script, p.data_generator, p.ready)
      job.name = name
      job.save
    end

    def last_task_completed?
      task = self.tasks.last
      unless task.nil?
        return task.completed?
      else
        false
      end
    end

    def sync_needed?
      t = tasks.order('created_at desc').first

      return true if t.nil?
      return false unless t.started?
      return true if t.started_at < self.updated_at

      return true if package_payload_sites.length - accounts_synced.length > 0

      return false
    end

    def post_to_leadtrac
      lead = Lead.new(self)
      lead.post
    end

    def set_times
      ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'].each do |day|
        self.send "#{day}_open=", '08:30AM' if self.send("#{day}_open") == nil
        self.send "#{day}_close=", '05:30PM'  if self.send("#{day}_close") == nil
      end
    end

    def list_payloads
      sub = self.subscription
      sites = []
      site_names = {} # HACK: Need to fix this bad.
      PackagePayload.by_package(sub.package_id).each do |obj|
        next if obj == nil
        site = obj.site
        next if site == nil
	unless site_names.has_key? site.name
	  sites.push site
          site_names[site.name] = true
        end
      end
      final = {}
      sites.each do |profile|
        if profile == nil
          final[profile.name] = {
            :id => nil,
            :name => profile.name,
            :enabled => false,
            :technical_notes => nil,
            :missing => true,
            :payloads => nil
          }
        else
          final[profile.name] = {
            :id => profile.id,
            :name => profile.name,
            :enabled => profile.enabled,
            :technical_notes => profile.technical_notes,
            :missing => false,
            :payloads => Payload.list(profile.name)
          }
        end
      end
      return final
    end

    def create_jobs
      sub = self.subscription

      # NOTE: temporary fix to get Bing/SignUp first
      bing = Payload.find_by_site_id_and_name(Site.find_by_name("Bing").id, "SignUp")
      if CompletedJob.where(:business_id => self.id, :name => "Bing/SignUp").count == 0
        job      = Job.inject(self.id, bing.client_script, bing.data_generator, bing.ready)
        job.name = "Bing/SignUp"
        job.save

        return # dont queue anything else until we have a bing sign up. 
      end

      PackagePayload.by_package(sub.package_id).each do |obj|
        site = obj.site
        next if site.nil?

        thereport = Report.where(:business_id => self.id).first
        if not thereport == nil
          thescan = Scan.where(:report_id => thereport.id).first
          if not thescan == nil
            if thescan.status == :claimed
              next
            end
          end
        end
        account = ClientData.get_sub_object( site.name, self )
        next if account.respond_to?(:do_not_sync) && account.do_not_sync
        mode = Mode.find_by_name("SignUp")
        mode = Mode.find_by_name("Update") if account && account.has_existing_credentials? 

        payload = Payload.where(:site_id => site.id, :mode_id => mode.id).root
        next unless payload
        next if payload.id == bing.id
        next if payload.paused_at

        job      = Job.inject(self.id, payload.client_script, payload.data_generator, payload.ready)
        job.name = "#{site.name}/#{payload.name}"
        job.save
      end
    end

    def accounts_synced
      last_sync_request = tasks.order('created_at desc').first
      last_sync_requested_at = last_sync_request.nil? ? Time.new(2013,1,1) : last_sync_request.created_at
      completed_sites = completed_jobs.where("created_at > ?", last_sync_requested_at).map{|j| j.name.split("/")[0] }
      completed_sites & package_payload_sites
    end

    def birthday
      if self.contact_birthday.blank? 
        date = Date.today - 30.year - (rand()*365).day
        self.contact_birthday = date.strftime( '%Y-%m-%d') # this really needs to be migrated to a date datatype
        self.save
      end
      Date.iso8601(self.contact_birthday)
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
      PackagePayload.by_package(self.subscription.package_id).each do |p|
        site = citation_site_hash[p.site]

        if site.nil?
          next if p.site == "Utils"
          non_account_data.push [p.site, 'Name not on citation list']
          next
        end

        if self.respond_to?(site[1]) and self.send(site[1]).count > 0
          previous_site_name = ""
          self.send(site[1]).each do |thing|
            row = ['','','','']
            row[0] = site[3].to_s

            next if previous_site_name == site[3].to_s
            previous_site_name = site[3].to_s

            username = thing.username if thing.respond_to?('username')
            username ||= thing.email if thing.respond_to?('email')
            username ||= ''
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

    def self.setup_completed_not_reported
      setup_completed_not_reported_businesses = Business.where("setup_completed <= ? AND setup_msg_sent = ?", 7.days.ago, false)
      return setup_completed_not_reported_businesses
    end

    def self.required?(attr)
      target = (Business.class == Class) ? Business : Business.class
      target.validators_on(attr).map(&:class).include?(ActiveModel::Validations::PresenceValidator)
    end
  end
end
