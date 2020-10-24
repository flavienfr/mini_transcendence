require "application_system_test_case"

class ChannelParticipationsTest < ApplicationSystemTestCase
  setup do
    @channel_participation = channel_participations(:one)
  end

  test "visiting the index" do
    visit channel_participations_url
    assert_selector "h1", text: "Channel Participations"
  end

  test "creating a Channel participation" do
    visit channel_participations_url
    click_on "New Channel Participation"

    fill_in "Channel", with: @channel_participation.channel_id
    check "Is admin" if @channel_participation.is_admin
    check "Is owner" if @channel_participation.is_owner
    fill_in "Status", with: @channel_participation.status
    fill_in "User", with: @channel_participation.user_id
    click_on "Create Channel participation"

    assert_text "Channel participation was successfully created"
    click_on "Back"
  end

  test "updating a Channel participation" do
    visit channel_participations_url
    click_on "Edit", match: :first

    fill_in "Channel", with: @channel_participation.channel_id
    check "Is admin" if @channel_participation.is_admin
    check "Is owner" if @channel_participation.is_owner
    fill_in "Status", with: @channel_participation.status
    fill_in "User", with: @channel_participation.user_id
    click_on "Update Channel participation"

    assert_text "Channel participation was successfully updated"
    click_on "Back"
  end

  test "destroying a Channel participation" do
    visit channel_participations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Channel participation was successfully destroyed"
  end
end
