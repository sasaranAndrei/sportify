require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get stats" do
    get players_stats_url
    assert_response :success
  end
end
