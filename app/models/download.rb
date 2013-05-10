require 'zip/zip'

class Download < ActiveRecord::Base
  belongs_to :user 

  def make_setup(business_id)
    c='abcdefghijklmnopqrstuvwxyz'
    setup = ''
    1.upto(10) do |i|
      setup += c[rand() * 26]
    end
    business = Business.find(business_id)
    original = Rails.root.join("labels", business.user.label.name, "Setup.exe").to_s
    STDERR.puts "#{original}"
    tmp      = Rails.root.join('tmp', setup)
    Dir.mkdir tmp unless File.exists? tmp
    file     = tmp.join(setup+'.exe').to_s
    system "cp \"#{original}\" \"#{file}\""
    dir  = nil
    Zip::ZipFile.open(file) { |zip_file|
      zip_file.each { |f|
        next unless f.name =~ /^(\d+)\\/
        dir = $1
      }
      STDERR.puts "Error: Could not find inner dir!" and return nil unless dir
    }

    STDERR.puts "Creating inner directory: #{dir}"
    full_dir = tmp.join(dir)
    Dir.mkdir full_dir unless File.exists? full_dir
    STDERR.puts "Writing key to #{full_dir}/key.txt..."
    key      = full_dir.join('key.txt')
    File.open(key, 'w') do |f|
      f.write self.key
    end
    bid      = full_dir.join('bid.txt')
    File.open(bid, 'w') do |f|
      f.write business_id.to_s
    end
    STDERR.puts "Adding #{full_dir}/key.txt to #{file}..."
    File.open(tmp.join("add.sh"), 'w') do |f|
      f.write "#!/bin/bash\ncd #{tmp}\nzip -0 \"#{file}\" \"#{dir}/key.txt\"\nzip -0 \"#{file}\" \"#{dir}/bid.txt\""
    end
    STDERR.puts "Writing:\n#!/bin/bash\ncd #{tmp}\nzip -0 \"#{file}\" \"#{dir}/key.txt\"\nzip -0 \"#{file}\" \"#{dir}/bid.txt\""
    STDERR.puts "To: #{tmp.join('add.sh')}"
    STDERR.puts "Running script.."

    # SIDE EFFECT: this (WAS) cross platform because the file extension
    # is ignored on Linux and the file is executed using the default
    # shell (bash). It happens that the commands are the same. Changed
    # to work on Linux exclusively now.
    system "chmod 750 #{tmp.join('add.sh').to_s}"
    system tmp.join('add.sh').to_s
    self.name = file
    file
  end
end
