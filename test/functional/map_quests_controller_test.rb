require 'test_helper'

class MapQuestsControllerTest < ActionController::TestCase
  setup do
    @map_quest = map_quests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:map_quests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create map_quest" do
    assert_difference('MapQuest.count') do
      post :create, map_quest: @map_quest.attributes
    end

    assert_redirected_to map_quest_path(assigns(:map_quest))
  end

  test "should show map_quest" do
    get :show, id: @map_quest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @map_quest
    assert_response :success
  end

  test "should update map_quest" do
    put :update, id: @map_quest, map_quest: @map_quest.attributes
    assert_redirected_to map_quest_path(assigns(:map_quest))
  end

  test "should destroy map_quest" do
    assert_difference('MapQuest.count', -1) do
      delete :destroy, id: @map_quest
    end

    assert_redirected_to map_quests_path
  end
end
