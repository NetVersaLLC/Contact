class AccountsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def create
		business = Business.find( params[:business_id] )
		if current_user.nil? or business.user_id != current_user.id
			redirect_to '/', :status => 403
		else
			STDERR.puts "HERE IS THE MODEL: "+params['model'].to_s
			model = Business.get_sub_model(params['model'])
			obj = model.where(:business_id => business.id).first
			unless obj
				obj = model.new
				obj.business_id = business.id
			end
			obj.update_attributes(params[obj.class.name.downcase])
			obj.save!
		end
		render json: {'status' => 'success'}
	end

  def edit 
		business = Business.find( params[:business_id] )
		if current_user.nil? or business.user_id != current_user.id
			redirect_to '/', :status => 403
		else
      @accounts = []
      Business.sub_models.each do |model| 
        obj = model.where(:business_id => business.id).first
        unless obj
          obj = model.new
          obj.business = business
        end
        @accounts << obj
      end 
		end
		render "edit", layout: false 
  end 

  def update 
		business = Business.find( params[:business_id] )
		if current_user.nil? or business.user_id != current_user.id
			redirect_to '/', :status => 403
		else
			model = Business.get_sub_model(params['model'])
			obj = model.where(:business_id => business.id).first
			obj.update_attributes(params[obj.class.name.downcase])
			obj.save!
		end
		render json: {'status' => 'success'}
  end 
end
