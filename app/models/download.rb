require 'zip/zip'

class Download < ActiveRecord::Base
  def make_setup
    c='abcdefghijklmnopqrstuvwxyz'
    setup = ''
    1.upto(10) do |i|
      setup += c[rand() * 26]
    end
    original = Rails.root.join("doc", "Setup.exe").to_s
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
    STDERR.puts "Adding #{full_dir}/key.txt to #{file}..."
    File.open(tmp.join("add.bat"), 'w') do |f|
      f.write "cd #{tmp}\r\nzip -0 \"#{file}\" \"#{dir}/key.txt\""
    end
    STDERR.puts "Writing: cd #{tmp}\r\nzip -0 \"#{file}\" \"#{dir}/key.txt\""
    STDERR.puts "To: #{tmp.join('add.bat')}"
    STDERR.puts "Running script.."
    system tmp.join('add.bat').to_s
    self.name = file
    file
  end
end
