namespace :yahoo do
  task :categories => :environment do
    File.open(Rails.root.join("categories", "yahoo", "final_list.txt"), 'r').each do |line|
      rcatid, catname, subcatid, subcatname, subprofcontact, synonyms = *line.split("\t")
      subprofcontact = subprofcontact == 'Y' ? true : false
      STDERR.puts "Adding: #{catname} -> #{subcatname}"
      YahooCategory.create do |y|
        y.rcatid         = rcatid
        y.catname        = catname
        y.subcatid       = subcatid
        y.subcatname     = subcatname
        y.subprofcontact = subprofcontact
        y.synonyms       = synonyms
      end
    end
  end
end
