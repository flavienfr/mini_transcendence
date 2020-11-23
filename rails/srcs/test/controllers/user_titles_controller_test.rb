require 'test_helper'

class UserTitlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_title = user_titles(:one)
  end

  test "should get index" do
    get user_titles_url
    assert_response :success
  end

  test "should get new" do
    get new_user_title_url
    assert_response :success
  end

  test "should create user_title" do
    assert_difference('UserTitle.count') do
      post user_titles_url, params: { user_title: { status: @user_title.status, title: @user_title.title, tournament_id: @user_title.tournament_id, user_id_id: @user_title.user_id_id } }
    end

    assert_redirected_to user_title_url(UserTitle.last)
  end

  test "should show user_title" do
    get user_title_url(@user_title)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_title_url(@user_title)
    assert_response :success
  end

  test "should update user_title" do
    patch user_title_url(@user_title), params: { user_title: { status: @user_title.status, title: @user_title.title, tournament_id: @user_title.tournament_id, user_id_id: @user_title.user_id_id } }
    assert_redirected_to user_title_url(@user_title)
  end

  test "should destroy user_title" do
    assert_difference('UserTitle.count', -1) do
      delete user_title_url(@user_title)
    end

    assert_redirected_to user_titles_url
  end
end
