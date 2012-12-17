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
      sub = nil
      # NOTE: this is probably a bug, leaving it since most accounts
      # will not have subscriptions initially
      if self.subscription_id == nil
        sub = Subscription.create do |sub|
          sub.package_id   = Package.first
          sub.package_name = Package.first.name
          sub.total        = Package.first.price
          sub.tos_agreed   = true
          sub.active       = true
        end
      else
        sub = self.subscription
      end
      PackagesPayloads.where(:package_id => sub.package_id).each do |obj|
        payload  = Payload.new( obj.site, obj.payload )
        job      = Job.inject(self.id, payload.payload, payload.data_generator, payload.ready)
        job.name = "#{obj.site}/#{obj.payload}"
        job.save
      end
    end

    def get_label
      self.user.label
    end

  end
end
