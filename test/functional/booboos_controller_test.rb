require 'test_helper'

class BooboosControllerTest < ActionController::TestCase
  setup do
    @booboo = booboos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:booboos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create booboo" do
    assert_difference('Booboo.count') do
      post :create, booboo: { business_id: @booboo.business_id, ip: @booboo.ip, message: @booboo.message, user_agent: @booboo.user_agent, user_id: @booboo.user_id }
    end

    assert_redirected_to booboo_path(assigns(:booboo))
  end

  test "should show booboo" do
    get :show, id: @booboo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @booboo
    assert_response :success
  end

  test "should update booboo" do
    put :update, id: @booboo, booboo: { business_id: @booboo.business_id, ip: @booboo.ip, message: @booboo.message, user_agent: @booboo.user_agent, user_id: @booboo.user_id }
    assert_redirected_to booboo_path(assigns(:booboo))
  end

  test "should destroy booboo" do
    assert_difference('Booboo.count', -1) do
      delete :destroy, id: @booboo
    end

    assert_redirected_to booboos_path
  end
end
