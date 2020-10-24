require "application_system_test_case"

class GuildParticipationsTest < ApplicationSystemTestCase
  setup do
    @guild_participation = guild_participations(:one)
  end

  test "visiting the index" do
    visit guild_participations_url
    assert_selector "h1", text: "Guild Participations"
  end

  test "creating a Guild participation" do
    visit guild_participations_url
    click_on "New Guild Participation"

    fill_in "Guild", with: @guild_participation.guild_id
    check "Is admin" if @guild_participation.is_admin
    check "Is officer" if @guild_participation.is_officer
    fill_in "User", with: @guild_participation.user_id
    click_on "Create Guild participation"

    assert_text "Guild participation was successfully created"
    click_on "Back"
  end

  test "updating a Guild participation" do
    visit guild_participations_url
    click_on "Edit", match: :first

    fill_in "Guild", with: @guild_participation.guild_id
    check "Is admin" if @guild_participation.is_admin
    check "Is officer" if @guild_participation.is_officer
    fill_in "User", with: @guild_participation.user_id
    click_on "Update Guild participation"

    assert_text "Guild participation was successfully updated"
    click_on "Back"
  end

  test "destroying a Guild participation" do
    visit guild_participations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Guild participation was successfully destroyed"
  end
end
