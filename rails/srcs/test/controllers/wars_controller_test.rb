require 'test_helper'

class WarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @war = wars(:one)
  end

  test "should get index" do
    get wars_url
    assert_response :success
  end

  test "should get new" do
    get new_war_url
    assert_response :success
  end

  test "should create war" do
    assert_difference('War.count') do
      post wars_url, params: { war: { end_date: @war.end_date, max_unanswered_call: @war.max_unanswered_call, prize_in_points: @war.prize_in_points, start_date: @war.start_date, status: @war.status, winner_id: @war.winner_id } }
    end

    assert_redirected_to war_url(War.last)
  end

  test "should show war" do
    get war_url(@war)
    assert_response :success
  end

  test "should get edit" do
    get edit_war_url(@war)
    assert_response :success
  end

  test "should update war" do
    patch war_url(@war), params: { war: { end_date: @war.end_date, max_unanswered_call: @war.max_unanswered_call, prize_in_points: @war.prize_in_points, start_date: @war.start_date, status: @war.status, winner_id: @war.winner_id } }
    assert_redirected_to war_url(@war)
  end

  test "should destroy war" do
    assert_difference('War.count', -1) do
      delete war_url(@war)
    end

    assert_redirected_to wars_url
  end
end
