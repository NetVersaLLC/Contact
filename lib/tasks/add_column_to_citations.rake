namespace :utils do 
  	desc "Add column 'do_not_sync' of type boolean all to citation tables"
  	task :add_column_to_citations => :environment do 
	
  		timestamp =  DateTime.parse(Time.now().to_s).iso8601.gsub(/\D/, '')[0..13]
      file_name = File.join(Rails.root, 'db', 'migrate', timestamp + '_add_column_to_citations.rb')
      File.open(file_name, 'w') do |mf|

        mf.puts "class AddColumnToCitations < ActiveRecord::Migration"
        mf.puts "\t def change"

          Business.citation_list.each do |table|
          table_name = table[1]
          mf.puts "\t\t add_column \t    :#{table_name}, :do_not_sync, :boolean, :default => false"
        end

        mf.puts "\t end" # end of change
        mf.puts "end" # end of class

		end
	end
end 

