require 'test_helper'

class BlockUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @block_user = block_users(:one)
  end

  test "should get index" do
    get block_users_url
    assert_response :success
  end

  test "should get new" do
    get new_block_user_url
    assert_response :success
  end

  test "should create block_user" do
    assert_difference('BlockUser.count') do
      post block_users_url, params: { block_user: { block_user_id: @block_user.block_user_id, status: @block_user.status, user_id: @block_user.user_id } }
    end

    assert_redirected_to block_user_url(BlockUser.last)
  end

  test "should show block_user" do
    get block_user_url(@block_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_block_user_url(@block_user)
    assert_response :success
  end

  test "should update block_user" do
    patch block_user_url(@block_user), params: { block_user: { block_user_id: @block_user.block_user_id, status: @block_user.status, user_id: @block_user.user_id } }
    assert_redirected_to block_user_url(@block_user)
  end

  test "should destroy block_user" do
    assert_difference('BlockUser.count', -1) do
      delete block_user_url(@block_user)
    end

    assert_redirected_to block_users_url
  end
end
