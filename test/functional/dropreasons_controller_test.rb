require 'test_helper'

class DropreasonsControllerTest < ActionController::TestCase
  setup do
    @dropreason = dropreasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dropreasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dropreason" do
    assert_difference('Dropreason.count') do
      post :create, dropreason: { name: @dropreason.name }
    end

    assert_redirected_to dropreason_path(assigns(:dropreason))
  end

  test "should show dropreason" do
    get :show, id: @dropreason
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dropreason
    assert_response :success
  end

  test "should update dropreason" do
    put :update, id: @dropreason, dropreason: { name: @dropreason.name }
    assert_redirected_to dropreason_path(assigns(:dropreason))
  end

  test "should destroy dropreason" do
    assert_difference('Dropreason.count', -1) do
      delete :destroy, id: @dropreason
    end

    assert_redirected_to dropreasons_path
  end
end
