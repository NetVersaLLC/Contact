class CategoriesController < ApplicationController
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
    params.each_key do |param|
      if param =~ /category_((.*?)Category)/
        model    = $2.constantize
        category = $1.constantize
        inst = nil
        if business.send( model.table_name ).count > 0
          inst = business.send( model.table_name ).first
        else
          inst = model.new
          inst.business_id = business.id
        end
        model.column_names.each do |column|
          if column =~ /category_id/
            inst.send("#{column}=", params[param])
            logger.info "Setting: #{column} = #{params[param]}"
          end
        end
        inst.save
      end
    end
    business.categorized = true
    business.save
    if business.errors.count > 0
      render json: {:status => :error, :errors => business.errors}
    else
      render json: {:status => :success}
    end
  end
  def update
  end
  def delete
  end
end
