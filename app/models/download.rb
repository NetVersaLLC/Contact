require 'zip/zip'

class Download < ActiveRecord::Base
  def make_setup
    c='abcdefghijklmnopqrstuvwxyz'
    setup = ''
    1.upto(10) do |i|
      setup += c[rand() * 26]
    end
    original = Rails.root.join("doc", "Setup.exe").to_s
    file     = Rails.root.join('tmp', setup+'.exe').to_s
    tmp      = Rails.root.join('tmp').to_s
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
    full_dir = Rails.root.join('tmp', dir).to_s
    Dir.mkdir full_dir unless File.exists? full_dir
    STDERR.puts "Writing key to #{dir}/key.txt..."
    key      = Rails.root.join('tmp', dir, setup+'.txt')
    File.open(key, 'w') do |f|
      f.write self.key
    end
    STDERR.puts "Adding #{dir}/key.txt to #{file}..."
    system "cd #{tmp} && zip -0 \"#{file}\" \"#{dir}/key.txt\""
    self.name = file
    file
  end
end
