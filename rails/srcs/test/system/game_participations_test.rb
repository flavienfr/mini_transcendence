require "application_system_test_case"

class GameParticipationsTest < ApplicationSystemTestCase
  setup do
    @game_participation = game_participations(:one)
  end

  test "visiting the index" do
    visit game_participations_url
    assert_selector "h1", text: "Game Participations"
  end

  test "creating a Game participation" do
    visit game_participations_url
    click_on "New Game Participation"

    fill_in "Game", with: @game_participation.game_id
    check "Is winner" if @game_participation.is_winner
    fill_in "Score", with: @game_participation.score
    fill_in "User", with: @game_participation.user_id
    click_on "Create Game participation"

    assert_text "Game participation was successfully created"
    click_on "Back"
  end

  test "updating a Game participation" do
    visit game_participations_url
    click_on "Edit", match: :first

    fill_in "Game", with: @game_participation.game_id
    check "Is winner" if @game_participation.is_winner
    fill_in "Score", with: @game_participation.score
    fill_in "User", with: @game_participation.user_id
    click_on "Update Game participation"

    assert_text "Game participation was successfully updated"
    click_on "Back"
  end

  test "destroying a Game participation" do
    visit game_participations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game participation was successfully destroyed"
  end
end
