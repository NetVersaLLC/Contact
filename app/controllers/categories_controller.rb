class CategoriesController < ApplicationController
  before_filter      :authenticate_admin!

  def index
    @business    = Business.find(params[:business_id])
    @categories  = []
    Business.citation_list.each do |data|
      model, table, rows = *data
      STDERR.puts "Working on: #{model}"
      rows.each do |cols|
        type, name = *cols
        if type == 'select'
	  klass = eval name.camelize
	  next if klass == GoogleCategory
	  next if klass == nil
	  thisRow = [klass, "/categories/#{klass}.js"]
	  res = ActiveRecord::Base.connection.execute "SELECT category_id FROM client_data WHERE business_id=#{@business.id} AND category_id IS NOT NULL AND type='#{data[0]}'"
          category_name = ''
          category_id   = ''
   res.each do |row|
	    category_id      = row.shift
	    category         = klass.where(:id => category_id).first
	    next if category == nil
	    category_name    = category.name
	    break
	  end
	  load_button = '<input type="button" onclick="window.loadCategory(\''+klass.to_s+'\')" value="Select" />'
	  thisRow.push "<div class='category_selected'>#{category_name} #{load_button}</div>"
	  thisRow.push category_id
	  @categories.push thisRow
        end
      end
   end
  end

  def show
    klass      = params[:model].constantize
    category   = klass.find(params[:id])
    render json: {:label => category.make_category, :model => params[:model]}
  end

  def create
    business = Business.find(params[:business_id])
    cats = params[:category]
    cats.each_key do |category_model|
      if category_model != nil and cats[category_model].to_i > 0 and category_model =~ /((.*?)Category)/
        if $2 == "FacebookProfile"
          model = "Facebook".constantize
        else
          model    = $2.constantize
        end
        category = $1.constantize

        inst = business.get_site(model)
        inst.category_id = cats[category_model]
        inst.save!
      end
    end

    business.categorized = params[:submit].present?
    business.category1   = params["business-category"]
    business.save :validate => false

    # if submit button clicked and the google business category has been set...
    if params[:submit].present? && params["business-category"].present? 
      g = GoogleCategory.where(name: params["business-category"]).first 
      if g.present? 
        a = {}
        params[:category].each do |k,v| 
          a[k.to_s.underscore + '_id'] = v
        end 
        logger.debug a
        g.update_attributes( a )
        g.save
      end 
    end 

    if business.errors.count > 0
      flash[:notice] = "Business profile is not complete!"
    else
      flash[:notice] = 'Saved'
    end
    redirect_to request.referer
  end

  def update
  end

  def delete
  end

  def google
    google_category = GoogleCategory.where(:name => params[:name]).last
    if google_category.nil? 
      render :nothing => true, status: :not_found
    else 
      render json: google_category
    end 
  end 

  def selectoptions
    klass = "#{params[:site]}Category".constantize
    @cachekey = "#{params[:site]} v3"
    @root = klass.find(1)
    respond_to do |format| 
      format.html {render "selectoptions", layout: false }
    end 
  end 

end
