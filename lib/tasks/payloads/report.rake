namespace :payloads do
  task :report => :environment do
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Payload Report") do |sheet|
        sheet.add_row ["Name", "Alexa Rank", "Working?", "Last Updated", "Notes"]
	Site.order("alexa_us_traffic_rank DESC").each do |site|
          status = site.enabled? ? 'Yes' : 'No'
          alexa = site.alexa_us_traffic_rank == nil  ? '' : site.alexa_us_traffic_rank.gsub(/[^0-9]/,'').to_i
	  sheet.add_row [site.name, alexa , status, site.updated_at, site.technical_notes]
	end
	p.serialize('report.xlsx')
      end
    end
  end
end
