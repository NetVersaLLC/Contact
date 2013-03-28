ActiveAdmin.register_page "Categories" do
  menu false

  content do
    business = Business.find(params[:business_id])
    h1(:id => 'categorized') do
      if business.categorized
        "Categorized"
      else
        "New"
      end
    end
    h2 do
      "Category: #{business.category1}"
    end
    form(:action => '/bunnies', :method => 'post') do
      Business.citation_list.each do |data|
        data[2].each do |row|
          if row[0] == 'select'
            klass = row[1].classify.constantize
            next if klass == YahooCategory
            script(:src => "/categories/#{klass}.js") do
            end
            category_name = nil
            category_id   = nil
            res = ActiveRecord::Base.connection.execute "SELECT #{row[1]}_id FROM #{data[1]} WHERE business_id=#{business.id} AND #{row[1]}_id IS NOT NULL"
            res.each do |row|
              logger.info "Row: #{row.inspect}"
              category_name = klass.find(row[0]).name
              category_id   = row[0]
            end
            unless category_name
              category_name = '<button onclick="loadCategory(\''+klass.to_s+'\')">Select</button>'
            end
            div(:class => 'category_show') do
              h2 do
                klass.to_s
              end
              h3(:id => "category_#{klass.to_s}") do 
                raw category_name
              end
              input(:type => 'hidden', :name => "category[#{klass.to_s}]", :id => "category_#{klass.to_s}", :value => category_id)
              div(:class => 'selector', :id => "selector_#{klass.to_s}") do
              end
            end
          end
        end
      end
      input(:type => :hidden, :id => 'business_id', :name => 'business_id', :value => business.id)
      input(:type => :button, :onclick => 'window.submitCategory()', :value => 'Submit')
    end
    res = ActiveRecord::Base.connection.execute("SELECT id FROM businesses WHERE id != #{business.id} AND categorized IS NULL")
    if res.count > 0
      nextBusiness = res.first
    end
    if nextBusiness
      form(:action => "/admin/categories", :method => :get) do
        input(:type => :hidden, :name => 'business_id', :value => nextBusiness[0])
        input(:type => :submit, :value => "Next")
      end
    end
  end
end

