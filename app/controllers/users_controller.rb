class UsersController < ApplicationController 

  def index 
    @users = User.accessible_by(current_ability)
  end 

end 
