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

    def report
      p = Axlsx::Package.new
      accounts = p.workbook.add_worksheet(:name => "Accounts")
      Business.citation_list.each do |site|
        STDERR.puts "Site: #{site[0]}"
        if self.respond_to?(site[1]) and self.send(site[1]).count > 0
          self.send(site[1]).each do |thing|
            row = [site[3]]
            site[2].each do |name|
              if name[0] == 'text'
                row.push thing.send(name[1])
              end
            end
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
      p.serialize(tmp)
      tmp
    end
  end
end
