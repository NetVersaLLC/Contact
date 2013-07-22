class CategoriesController < ApplicationController
  before_filter      :authenticate_user!
  def index
    klass      = params[:model].constantize
    category   = klass.find(params[:id])
    categories = klass.blist_categories(category)
    render json: {:categories => categories, :count => categories.length}
  end
  def show
    klass      = params[:model].constantize
    category   = klass.find(params[:id])
    render json: {:label => category.make_category, :model => params[:model]}
  end
  def create
    business = Business.find(params[:business_id])
    params[:category].each do |pair|
      logger.info "Checking: #{pair}"
      if pair[1] != nil and pair[1].to_i > 0 and pair[0] =~ /((.*?)Category)/
        if $2 == "FacebookProfile"
          model = "Facebook".constantize
        else
          model    = $2.constantize
        end
        category = $1.constantize

        inst = nil
        if business.send( model.table_name ).count > 0
          inst = business.send( model.table_name ).first
          logger.info "Found instance"
        else
          inst = model.new
          inst.business_id = business.id
          logger.info "Created instance"
        end
        model.column_names.each do |column|
          if column =~ /category_id/
            inst.send("#{column}=", pair[1])
            logger.info "Setting: #{column} = #{pair[1]}"
          end
        end
        inst.save
      end
    end
    business.categorized = true
    business.save :validate => false
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
end
