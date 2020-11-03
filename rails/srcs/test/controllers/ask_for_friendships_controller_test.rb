require 'test_helper'

class AskForFriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ask_for_friendship = ask_for_friendships(:one)
  end

  test "should get index" do
    get ask_for_friendships_url
    assert_response :success
  end

  test "should get new" do
    get new_ask_for_friendship_url
    assert_response :success
  end

  test "should create ask_for_friendship" do
    assert_difference('AskForFriendship.count') do
      post ask_for_friendships_url, params: { ask_for_friendship: { friendship_id: @ask_for_friendship.friendship_id, from_user_id: @ask_for_friendship.from_user_id, status: @ask_for_friendship.status, to_user_id: @ask_for_friendship.to_user_id } }
    end

    assert_redirected_to ask_for_friendship_url(AskForFriendship.last)
  end

  test "should show ask_for_friendship" do
    get ask_for_friendship_url(@ask_for_friendship)
    assert_response :success
  end

  test "should get edit" do
    get edit_ask_for_friendship_url(@ask_for_friendship)
    assert_response :success
  end

  test "should update ask_for_friendship" do
    patch ask_for_friendship_url(@ask_for_friendship), params: { ask_for_friendship: { friendship_id: @ask_for_friendship.friendship_id, from_user_id: @ask_for_friendship.from_user_id, status: @ask_for_friendship.status, to_user_id: @ask_for_friendship.to_user_id } }
    assert_redirected_to ask_for_friendship_url(@ask_for_friendship)
  end

  test "should destroy ask_for_friendship" do
    assert_difference('AskForFriendship.count', -1) do
      delete ask_for_friendship_url(@ask_for_friendship)
    end

    assert_redirected_to ask_for_friendships_url
  end
end
