require 'test_helper'

class WarParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @war_participation = war_participations(:one)
  end

  test "should get index" do
    get war_participations_url
    assert_response :success
  end

  test "should get new" do
    get new_war_participation_url
    assert_response :success
  end

  test "should create war_participation" do
    assert_difference('WarParticipation.count') do
      post war_participations_url, params: { war_participation: { guild_id: @war_participation.guild_id, has_declared_war: @war_participation.has_declared_war, is_winner: @war_participation.is_winner, nb_unanswered_call: @war_participation.nb_unanswered_call, status: @war_participation.status, war_id: @war_participation.war_id, war_points: @war_participation.war_points } }
    end

    assert_redirected_to war_participation_url(WarParticipation.last)
  end

  test "should show war_participation" do
    get war_participation_url(@war_participation)
    assert_response :success
  end

  test "should get edit" do
    get edit_war_participation_url(@war_participation)
    assert_response :success
  end

  test "should update war_participation" do
    patch war_participation_url(@war_participation), params: { war_participation: { guild_id: @war_participation.guild_id, has_declared_war: @war_participation.has_declared_war, is_winner: @war_participation.is_winner, nb_unanswered_call: @war_participation.nb_unanswered_call, status: @war_participation.status, war_id: @war_participation.war_id, war_points: @war_participation.war_points } }
    assert_redirected_to war_participation_url(@war_participation)
  end

  test "should destroy war_participation" do
    assert_difference('WarParticipation.count', -1) do
      delete war_participation_url(@war_participation)
    end

    assert_redirected_to war_participations_url
  end
end
