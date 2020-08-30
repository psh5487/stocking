require 'test_helper'

class MadebyControllerTest < ActionController::TestCase
  test "should get yeah" do
    get :yeah
    assert_response :success
  end

end
