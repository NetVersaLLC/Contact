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
      p = Axlsx::Package.new
      accounts = p.workbook.add_worksheet(:name => "Accounts")
      Business.citation_list.each do |site|
        STDERR.puts "Site: #{site[0]}"
        logger.debug site.inspect
        if self.respond_to?(site[1]) and self.send(site[1]).count > 0
          self.send(site[1]).each do |thing|
            row = [site[3]]

            username = thing.username if thing.respond_to?('username') 
            username ||= thing.email if thing.respond_to?('email') 
            username ||= 'submitted' 
            password = thing.password if thing.respond_to?('password') 
            password ||= '' 
            row.push username
            row.push password 

            site[2].each do |name|
              next if %w(email username password).include?(name[1])

              if name[0] == 'text'
                row.push thing.send(name[1])
              end
            end
            logger.debug row.inspect 
            accounts.add_row row
          end
        else
          STDERR.puts "Nothing for: #{site[1]}"
        end
      end
      completed = p.workbook.add_worksheet(:name => "Completed")
      ran = {}
      CompletedJob.where(:business_id => self.id).each do |row|
        ran[row.name.split("/")[0]] = 'Completed'
      end
      ran.each_key do |site|
        completed.add_row [site, 'Completed']
      end
      c='abcdefghijklmnopqrstuvwxyz'
      setup = ''
      1.upto(10) do |i|
        setup += c[rand() * 26]
      end
      tmp      = Rails.root.join('tmp', "#{setup}.xlsx")
      # for iWork numbers 
      p.use_shared_strings = true
      p.serialize(tmp)
      tmp
    end

  end

  def report_pdf
	pdf = Prawn::Document.new

	pdf.text('Account Information')
	Business.citation_list.each do |site|
        STDERR.puts "Site: #{site[0]}"
        logger.debug site.inspect
		if self.respond_to?(site[1]) and self.send(site[1]).count > 0

		  self.send(site[1]).each do |thing|
            row = [site[3]]

            username = thing.username if thing.respond_to?('username') 
            username ||= thing.email if thing.respond_to?('email') 
            username ||= 'submitted' 
            password = thing.password if thing.respond_to?('password') 
            password ||= '' 
            row.push username
            row.push password 

            site[2].each do |name|
              next if %w(email username password).include?(name[1])

              if name[0] == 'text'
                row.push thing.send(name[1])
              end
            end
            logger.debug row.inspect 

			line = row.join(', ')
			pdf.text(line)
          end

		else
          STDERR.puts "Nothing for: #{site[1]}"
		end
	end

	pdf.text('Completed Jobs Information')
	ran = {}
	CompletedJob.where(:business_id => self.id).each do |row|
		ran[row.name.split("/")[0]] = 'Completed'
	end

	ran.each_key do |site|
		pdf.text(site + ', Completed')
	end

	c='abcdefghijklmnopqrstuvwxyz'
	setup = ''
	1.upto(10) do |i|
		setup += c[rand() * 26]
	end
	tmp  = Rails.root.join('tmp', "#{setup}.pdf")

	pdf.render_file tmp
	
	return tmp

  end

end
