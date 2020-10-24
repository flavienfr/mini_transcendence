require 'test_helper'

class AskForGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ask_for_game = ask_for_games(:one)
  end

  test "should get index" do
    get ask_for_games_url
    assert_response :success
  end

  test "should get new" do
    get new_ask_for_game_url
    assert_response :success
  end

  test "should create ask_for_game" do
    assert_difference('AskForGame.count') do
      post ask_for_games_url, params: { ask_for_game: { from_user_id: @ask_for_game.from_user_id, status: @ask_for_game.status, to_user_id: @ask_for_game.to_user_id } }
    end

    assert_redirected_to ask_for_game_url(AskForGame.last)
  end

  test "should show ask_for_game" do
    get ask_for_game_url(@ask_for_game)
    assert_response :success
  end

  test "should get edit" do
    get edit_ask_for_game_url(@ask_for_game)
    assert_response :success
  end

  test "should update ask_for_game" do
    patch ask_for_game_url(@ask_for_game), params: { ask_for_game: { from_user_id: @ask_for_game.from_user_id, status: @ask_for_game.status, to_user_id: @ask_for_game.to_user_id } }
    assert_redirected_to ask_for_game_url(@ask_for_game)
  end

  test "should destroy ask_for_game" do
    assert_difference('AskForGame.count', -1) do
      delete ask_for_game_url(@ask_for_game)
    end

    assert_redirected_to ask_for_games_url
  end
end
