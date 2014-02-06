require File.dirname(__FILE__) + '/../spec_helper'

describe FailedJobsController do


  it 'should not allow anonymous access' do 
    get :index 
    response.should redirect_to '/users/sign_in'
  end 

  it 'should not allow user access' do 
    user = User.create(email: 'user@test.dev', password: 'password', password_confirmation: 'password')
    sign_in user 

    get :index 
    response.should redirect_to root_path
  end 

  it 'should allow reseller access' do 
    user = User.create(email: 'user@test.dev', password: 'password', password_confirmation: 'password')
    user.access_level = User.reseller
    user.save

    sign_in user 

    get :index 
    expect(response).to render_template("index")
  end 
end 

