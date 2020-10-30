require "application_system_test_case"

class TournamentParticipationsTest < ApplicationSystemTestCase
  setup do
    @tournament_participation = tournament_participations(:one)
  end

  test "visiting the index" do
    visit tournament_participations_url
    assert_selector "h1", text: "Tournament Participations"
  end

  test "creating a Tournament participation" do
    visit tournament_participations_url
    click_on "New Tournament Participation"

    fill_in "Nb lose game", with: @tournament_participation.nb_lose_game
    fill_in "Nb won game", with: @tournament_participation.nb_won_game
    fill_in "Score", with: @tournament_participation.score
    fill_in "Status", with: @tournament_participation.status
    fill_in "Tournament", with: @tournament_participation.tournament_id
    fill_in "User", with: @tournament_participation.user_id
    click_on "Create Tournament participation"

    assert_text "Tournament participation was successfully created"
    click_on "Back"
  end

  test "updating a Tournament participation" do
    visit tournament_participations_url
    click_on "Edit", match: :first

    fill_in "Nb lose game", with: @tournament_participation.nb_lose_game
    fill_in "Nb won game", with: @tournament_participation.nb_won_game
    fill_in "Score", with: @tournament_participation.score
    fill_in "Status", with: @tournament_participation.status
    fill_in "Tournament", with: @tournament_participation.tournament_id
    fill_in "User", with: @tournament_participation.user_id
    click_on "Update Tournament participation"

    assert_text "Tournament participation was successfully updated"
    click_on "Back"
  end

  test "destroying a Tournament participation" do
    visit tournament_participations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tournament participation was successfully destroyed"
  end
end
