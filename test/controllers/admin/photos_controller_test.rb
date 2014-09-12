require 'test_helper'

class Admin::PhotosControllerTest < ActionController::TestCase
  test "should get update_show" do
    get :update_show
    assert_response :success
  end

end
