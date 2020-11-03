require 'test_helper'

class TournamentParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tournament_participation = tournament_participations(:one)
  end

  test "should get index" do
    get tournament_participations_url
    assert_response :success
  end

  test "should get new" do
    get new_tournament_participation_url
    assert_response :success
  end

  test "should create tournament_participation" do
    assert_difference('TournamentParticipation.count') do
      post tournament_participations_url, params: { tournament_participation: { nb_lose_game: @tournament_participation.nb_lose_game, nb_won_game: @tournament_participation.nb_won_game, score: @tournament_participation.score, status: @tournament_participation.status, tournament_id: @tournament_participation.tournament_id, user_id: @tournament_participation.user_id } }
    end

    assert_redirected_to tournament_participation_url(TournamentParticipation.last)
  end

  test "should show tournament_participation" do
    get tournament_participation_url(@tournament_participation)
    assert_response :success
  end

  test "should get edit" do
    get edit_tournament_participation_url(@tournament_participation)
    assert_response :success
  end

  test "should update tournament_participation" do
    patch tournament_participation_url(@tournament_participation), params: { tournament_participation: { nb_lose_game: @tournament_participation.nb_lose_game, nb_won_game: @tournament_participation.nb_won_game, score: @tournament_participation.score, status: @tournament_participation.status, tournament_id: @tournament_participation.tournament_id, user_id: @tournament_participation.user_id } }
    assert_redirected_to tournament_participation_url(@tournament_participation)
  end

  test "should destroy tournament_participation" do
    assert_difference('TournamentParticipation.count', -1) do
      delete tournament_participation_url(@tournament_participation)
    end

    assert_redirected_to tournament_participations_url
  end
end
