require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get play_game" do
    get games_play_game_url
    assert_response :success
  end

  test "should get submit_game" do
    get games_submit_game_url
    assert_response :success
  end
end
