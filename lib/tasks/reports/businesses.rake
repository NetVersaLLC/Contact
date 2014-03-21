namespace :reports do
  task :full => :environment do 
     report_dir = Rails.root.join('public', 'businesses')
     content = File.read(Rails.root.join('app', 'views', 'layouts','business_report.html.erb'))
     template = ERB.new(content)

     businesses = Business.all.take(20)
     #Business.all.each do |b|
     businesses.each do |b|
       @business = b
       @data = [ ]
       b.subscription.package.package_payloads.each do |pp| 
         root = Payload.where(:parent_id => nil, :site_id => pp.site_id, :mode_id => 2).first
         total, completed = calculate(root, b.id)
         percent = (total == 0) ? 'NA' : completed/total*100
         row = {'site' => pp.site.name,
                'total' => total,
                'completed' => completed,
                'uncompleted' => total - completed,
                'percent' => percent
            }
          @data.push row
          
       end
       
       File.open(Rails.root.join("public", "businesses", "business_#{b.id}.html"), 'w') { |f| f.puts(template.result) }
       
     end

  end
  
  def calculate(payload, business_id)
    total = 0
    completed = 0
    if payload != nil
      total = 1
      completed = CompletedJob.where(:business_id => business_id, :name => payload.name).count
      
      payload.children.each do |c|
        ctotal, ccompleted = calculate(c, business_id)
        total += ctotal
        completed += ccompleted
      end
    end
    
    return [total, completed]
  end
end