namespace :payloads do
  task :add_to_nodes => :environment do
    PayloadNode.delete_all
    ActiveRecord::Base.connection.execute "ALTER TABLE payload_nodes AUTO_INCREMENT=1"
    root = PayloadNode.create do |p|
      p.name = "Utils/ImageSync"
      p.parent_id = nil
    end
    bing = PayloadNode.create do |p|
      p.name = "Bing/SignUp"
      p.parent_id = root.id
    end
    PackagePayload.by_package(1).each do |package|
      PayloadNode.add_recursive("#{package.site}/#{package.payload}", bing.id)
    end
  end
end
