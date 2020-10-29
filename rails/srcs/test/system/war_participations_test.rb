require "application_system_test_case"

class WarParticipationsTest < ApplicationSystemTestCase
  setup do
    @war_participation = war_participations(:one)
  end

  test "visiting the index" do
    visit war_participations_url
    assert_selector "h1", text: "War Participations"
  end

  test "creating a War participation" do
    visit war_participations_url
    click_on "New War Participation"

    fill_in "Guild", with: @war_participation.guild_id
    check "Has declared war" if @war_participation.has_declared_war
    check "Is winner" if @war_participation.is_winner
    fill_in "Nb unanswered call", with: @war_participation.nb_unanswered_call
    fill_in "Status", with: @war_participation.status
    fill_in "War", with: @war_participation.war_id
    fill_in "War points", with: @war_participation.war_points
    click_on "Create War participation"

    assert_text "War participation was successfully created"
    click_on "Back"
  end

  test "updating a War participation" do
    visit war_participations_url
    click_on "Edit", match: :first

    fill_in "Guild", with: @war_participation.guild_id
    check "Has declared war" if @war_participation.has_declared_war
    check "Is winner" if @war_participation.is_winner
    fill_in "Nb unanswered call", with: @war_participation.nb_unanswered_call
    fill_in "Status", with: @war_participation.status
    fill_in "War", with: @war_participation.war_id
    fill_in "War points", with: @war_participation.war_points
    click_on "Update War participation"

    assert_text "War participation was successfully updated"
    click_on "Back"
  end

  test "destroying a War participation" do
    visit war_participations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "War participation was successfully destroyed"
  end
end
