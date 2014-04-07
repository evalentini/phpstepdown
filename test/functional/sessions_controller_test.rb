require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get gate" do
    get :gate
    assert_response :success
  end

end
