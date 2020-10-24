require 'test_helper'

class ChannelParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @channel_participation = channel_participations(:one)
  end

  test "should get index" do
    get channel_participations_url
    assert_response :success
  end

  test "should get new" do
    get new_channel_participation_url
    assert_response :success
  end

  test "should create channel_participation" do
    assert_difference('ChannelParticipation.count') do
      post channel_participations_url, params: { channel_participation: { channel_id: @channel_participation.channel_id, is_admin: @channel_participation.is_admin, is_owner: @channel_participation.is_owner, status: @channel_participation.status, user_id: @channel_participation.user_id } }
    end

    assert_redirected_to channel_participation_url(ChannelParticipation.last)
  end

  test "should show channel_participation" do
    get channel_participation_url(@channel_participation)
    assert_response :success
  end

  test "should get edit" do
    get edit_channel_participation_url(@channel_participation)
    assert_response :success
  end

  test "should update channel_participation" do
    patch channel_participation_url(@channel_participation), params: { channel_participation: { channel_id: @channel_participation.channel_id, is_admin: @channel_participation.is_admin, is_owner: @channel_participation.is_owner, status: @channel_participation.status, user_id: @channel_participation.user_id } }
    assert_redirected_to channel_participation_url(@channel_participation)
  end

  test "should destroy channel_participation" do
    assert_difference('ChannelParticipation.count', -1) do
      delete channel_participation_url(@channel_participation)
    end

    assert_redirected_to channel_participations_url
  end
end
