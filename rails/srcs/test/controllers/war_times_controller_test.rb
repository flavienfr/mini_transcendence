require 'test_helper'

class WarTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @war_time = war_times(:one)
  end

  test "should get index" do
    get war_times_url
    assert_response :success
  end

  test "should get new" do
    get new_war_time_url
    assert_response :success
  end

  test "should create war_time" do
    assert_difference('WarTime.count') do
      post war_times_url, params: { war_time: { a: @war_time.a, b: @war_time.b, end_date: @war_time.end_date, nb_unanswered_call_a: @war_time.nb_unanswered_call_a, nb_unanswered_call_b: @war_time.nb_unanswered_call_b, ongoing_match: @war_time.ongoing_match, start_date: @war_time.start_date, status: @war_time.status, war_id: @war_time.war_id } }
    end

    assert_redirected_to war_time_url(WarTime.last)
  end

  test "should show war_time" do
    get war_time_url(@war_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_war_time_url(@war_time)
    assert_response :success
  end

  test "should update war_time" do
    patch war_time_url(@war_time), params: { war_time: { a: @war_time.a, b: @war_time.b, end_date: @war_time.end_date, nb_unanswered_call_a: @war_time.nb_unanswered_call_a, nb_unanswered_call_b: @war_time.nb_unanswered_call_b, ongoing_match: @war_time.ongoing_match, start_date: @war_time.start_date, status: @war_time.status, war_id: @war_time.war_id } }
    assert_redirected_to war_time_url(@war_time)
  end

  test "should destroy war_time" do
    assert_difference('WarTime.count', -1) do
      delete war_time_url(@war_time)
    end

    assert_redirected_to war_times_url
  end
end
