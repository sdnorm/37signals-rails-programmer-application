require "test_helper"

class DateParserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get date_parser_index_url
    assert_response :success
  end
end
