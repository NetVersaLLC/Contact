class UsersController < ApplicationController 
  load_and_authorize_resource 

  protected 
  	def collection 
  		@users ||= end_of_association_chain.accessible_by(current_ability)
  	end

end 
