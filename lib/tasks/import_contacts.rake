require 'csv'

namespace :netversa do
  task :import_contacts do
    headers = nil
    CSV.open(Rails.root.join("doc", "export.csv")).each do |r|
      headers = r and next unless headers
      row = {}
      0.upto(row.length - 1) { |i| row[headers[i]] = r[i] }
      break
    end
    headers.each do |h|
      puts h
    end
  end
end
