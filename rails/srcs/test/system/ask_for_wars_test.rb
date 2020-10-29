require "application_system_test_case"

class AskForWarsTest < ApplicationSystemTestCase
  setup do
    @ask_for_war = ask_for_wars(:one)
  end

  test "visiting the index" do
    visit ask_for_wars_url
    assert_selector "h1", text: "Ask For Wars"
  end

  test "creating a Ask for war" do
    visit ask_for_wars_url
    click_on "New Ask For War"

    fill_in "From guild", with: @ask_for_war.from_guild_id
    check "Includes ladder" if @ask_for_war.includes_ladder
    fill_in "Status", with: @ask_for_war.status
    fill_in "Terms", with: @ask_for_war.terms
    fill_in "To guild", with: @ask_for_war.to_guild_id
    fill_in "War", with: @ask_for_war.war_id
    click_on "Create Ask for war"

    assert_text "Ask for war was successfully created"
    click_on "Back"
  end

  test "updating a Ask for war" do
    visit ask_for_wars_url
    click_on "Edit", match: :first

    fill_in "From guild", with: @ask_for_war.from_guild_id
    check "Includes ladder" if @ask_for_war.includes_ladder
    fill_in "Status", with: @ask_for_war.status
    fill_in "Terms", with: @ask_for_war.terms
    fill_in "To guild", with: @ask_for_war.to_guild_id
    fill_in "War", with: @ask_for_war.war_id
    click_on "Update Ask for war"

    assert_text "Ask for war was successfully updated"
    click_on "Back"
  end

  test "destroying a Ask for war" do
    visit ask_for_wars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ask for war was successfully destroyed"
  end
end
