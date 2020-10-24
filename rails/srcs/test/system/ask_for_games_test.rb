require "application_system_test_case"

class AskForGamesTest < ApplicationSystemTestCase
  setup do
    @ask_for_game = ask_for_games(:one)
  end

  test "visiting the index" do
    visit ask_for_games_url
    assert_selector "h1", text: "Ask For Games"
  end

  test "creating a Ask for game" do
    visit ask_for_games_url
    click_on "New Ask For Game"

    fill_in "From user", with: @ask_for_game.from_user_id
    fill_in "Status", with: @ask_for_game.status
    fill_in "To user", with: @ask_for_game.to_user_id
    click_on "Create Ask for game"

    assert_text "Ask for game was successfully created"
    click_on "Back"
  end

  test "updating a Ask for game" do
    visit ask_for_games_url
    click_on "Edit", match: :first

    fill_in "From user", with: @ask_for_game.from_user_id
    fill_in "Status", with: @ask_for_game.status
    fill_in "To user", with: @ask_for_game.to_user_id
    click_on "Update Ask for game"

    assert_text "Ask for game was successfully updated"
    click_on "Back"
  end

  test "destroying a Ask for game" do
    visit ask_for_games_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ask for game was successfully destroyed"
  end
end
