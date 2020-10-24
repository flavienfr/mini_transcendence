require 'test_helper'

class UserAchievementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_achievement = user_achievements(:one)
  end

  test "should get index" do
    get user_achievements_url
    assert_response :success
  end

  test "should get new" do
    get new_user_achievement_url
    assert_response :success
  end

  test "should create user_achievement" do
    assert_difference('UserAchievement.count') do
      post user_achievements_url, params: { user_achievement: { achievement_id: @user_achievement.achievement_id, status: @user_achievement.status, user_id: @user_achievement.user_id } }
    end

    assert_redirected_to user_achievement_url(UserAchievement.last)
  end

  test "should show user_achievement" do
    get user_achievement_url(@user_achievement)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_achievement_url(@user_achievement)
    assert_response :success
  end

  test "should update user_achievement" do
    patch user_achievement_url(@user_achievement), params: { user_achievement: { achievement_id: @user_achievement.achievement_id, status: @user_achievement.status, user_id: @user_achievement.user_id } }
    assert_redirected_to user_achievement_url(@user_achievement)
  end

  test "should destroy user_achievement" do
    assert_difference('UserAchievement.count', -1) do
      delete user_achievement_url(@user_achievement)
    end

    assert_redirected_to user_achievements_url
  end
end
