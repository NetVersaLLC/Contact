namespace :generate do
  task :sitelist => :environment do
    require 'csv'
    built = []
    Business.citation_list.each do |item|
      next unless File.exists? Rails.root.join('sites', item[0], 'SearchListing')
      number = rand() * 100
      if number >= 80
        built.push [item[3], :claimed, :yes]
      elsif number >= 60
        built.push [item[3], :claimed, :no]
      elsif number >= 40
        built.push [item[3], :unclaimed, :yes]
      elsif number >= 20
        built.push [item[3], :unclaimed, :no]
      elsif number >= 10
        built.push [item[3], :unlisted, :no]
      else
        built.push [item[3], :unlisted, :yes]
      end
      puts built[-1].to_csv
    end
    # puts built.to_json
  end
end
