require "application_system_test_case"

class NotificationsTest < ApplicationSystemTestCase
  setup do
    @notification = notifications(:one)
  end

  test "visiting the index" do
    visit notifications_url
    assert_selector "h1", text: "Notifications"
  end

  test "creating a Notification" do
    visit notifications_url
    click_on "New Notification"

    fill_in "From user", with: @notification.from_user_id
    fill_in "Message", with: @notification.message
    fill_in "Status", with: @notification.status
    fill_in "To channel", with: @notification.to_channel_id
    fill_in "To guild", with: @notification.to_guild_id
    fill_in "To user", with: @notification.to_user_id
    fill_in "Type", with: @notification.type
    click_on "Create Notification"

    assert_text "Notification was successfully created"
    click_on "Back"
  end

  test "updating a Notification" do
    visit notifications_url
    click_on "Edit", match: :first

    fill_in "From user", with: @notification.from_user_id
    fill_in "Message", with: @notification.message
    fill_in "Status", with: @notification.status
    fill_in "To channel", with: @notification.to_channel_id
    fill_in "To guild", with: @notification.to_guild_id
    fill_in "To user", with: @notification.to_user_id
    fill_in "Type", with: @notification.type
    click_on "Update Notification"

    assert_text "Notification was successfully updated"
    click_on "Back"
  end

  test "destroying a Notification" do
    visit notifications_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Notification was successfully destroyed"
  end
end
