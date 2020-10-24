require 'test_helper'

class GameParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_participation = game_participations(:one)
  end

  test "should get index" do
    get game_participations_url
    assert_response :success
  end

  test "should get new" do
    get new_game_participation_url
    assert_response :success
  end

  test "should create game_participation" do
    assert_difference('GameParticipation.count') do
      post game_participations_url, params: { game_participation: { game_id: @game_participation.game_id, is_winner: @game_participation.is_winner, score: @game_participation.score, user_id: @game_participation.user_id } }
    end

    assert_redirected_to game_participation_url(GameParticipation.last)
  end

  test "should show game_participation" do
    get game_participation_url(@game_participation)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_participation_url(@game_participation)
    assert_response :success
  end

  test "should update game_participation" do
    patch game_participation_url(@game_participation), params: { game_participation: { game_id: @game_participation.game_id, is_winner: @game_participation.is_winner, score: @game_participation.score, user_id: @game_participation.user_id } }
    assert_redirected_to game_participation_url(@game_participation)
  end

  test "should destroy game_participation" do
    assert_difference('GameParticipation.count', -1) do
      delete game_participation_url(@game_participation)
    end

    assert_redirected_to game_participations_url
  end
end
