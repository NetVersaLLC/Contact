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
            category_name = ''
            if business.send(data[1]).count > 0
              site = business.send(data[1]).first
              if site
                category = site.send("#{row[1]}_id")
                if category
                  category_name = klass.find(category).make_category
                end
              end
            end
            render :partial => 'show', :locals => { :klass => klass, :category_name => category_name }
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

