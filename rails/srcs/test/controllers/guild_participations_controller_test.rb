require 'test_helper'

class GuildParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guild_participation = guild_participations(:one)
  end

  test "should get index" do
    get guild_participations_url
    assert_response :success
  end

  test "should get new" do
    get new_guild_participation_url
    assert_response :success
  end

  test "should create guild_participation" do
    assert_difference('GuildParticipation.count') do
      post guild_participations_url, params: { guild_participation: { guild_id: @guild_participation.guild_id, is_admin: @guild_participation.is_admin, is_officer: @guild_participation.is_officer, user_id: @guild_participation.user_id } }
    end

    assert_redirected_to guild_participation_url(GuildParticipation.last)
  end

  test "should show guild_participation" do
    get guild_participation_url(@guild_participation)
    assert_response :success
  end

  test "should get edit" do
    get edit_guild_participation_url(@guild_participation)
    assert_response :success
  end

  test "should update guild_participation" do
    patch guild_participation_url(@guild_participation), params: { guild_participation: { guild_id: @guild_participation.guild_id, is_admin: @guild_participation.is_admin, is_officer: @guild_participation.is_officer, user_id: @guild_participation.user_id } }
    assert_redirected_to guild_participation_url(@guild_participation)
  end

  test "should destroy guild_participation" do
    assert_difference('GuildParticipation.count', -1) do
      delete guild_participation_url(@guild_participation)
    end

    assert_redirected_to guild_participations_url
  end
end
