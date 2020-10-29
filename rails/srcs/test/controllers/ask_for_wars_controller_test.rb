require 'test_helper'

class AskForWarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ask_for_war = ask_for_wars(:one)
  end

  test "should get index" do
    get ask_for_wars_url
    assert_response :success
  end

  test "should get new" do
    get new_ask_for_war_url
    assert_response :success
  end

  test "should create ask_for_war" do
    assert_difference('AskForWar.count') do
      post ask_for_wars_url, params: { ask_for_war: { from_guild_id: @ask_for_war.from_guild_id, includes_ladder: @ask_for_war.includes_ladder, status: @ask_for_war.status, terms: @ask_for_war.terms, to_guild_id: @ask_for_war.to_guild_id, war_id: @ask_for_war.war_id } }
    end

    assert_redirected_to ask_for_war_url(AskForWar.last)
  end

  test "should show ask_for_war" do
    get ask_for_war_url(@ask_for_war)
    assert_response :success
  end

  test "should get edit" do
    get edit_ask_for_war_url(@ask_for_war)
    assert_response :success
  end

  test "should update ask_for_war" do
    patch ask_for_war_url(@ask_for_war), params: { ask_for_war: { from_guild_id: @ask_for_war.from_guild_id, includes_ladder: @ask_for_war.includes_ladder, status: @ask_for_war.status, terms: @ask_for_war.terms, to_guild_id: @ask_for_war.to_guild_id, war_id: @ask_for_war.war_id } }
    assert_redirected_to ask_for_war_url(@ask_for_war)
  end

  test "should destroy ask_for_war" do
    assert_difference('AskForWar.count', -1) do
      delete ask_for_war_url(@ask_for_war)
    end

    assert_redirected_to ask_for_wars_url
  end
end
