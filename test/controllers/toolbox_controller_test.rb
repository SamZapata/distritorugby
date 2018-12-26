require 'test_helper'

class ToolboxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get toolbox_index_url
    assert_response :success
  end

end
