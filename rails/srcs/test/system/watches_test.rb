require "application_system_test_case"

class WatchesTest < ApplicationSystemTestCase
  setup do
    @watch = watches(:one)
  end

  test "visiting the index" do
    visit watches_url
    assert_selector "h1", text: "Watches"
  end

  test "creating a Watch" do
    visit watches_url
    click_on "New Watch"

    fill_in "Hostid", with: @watch.hostId
    fill_in "User", with: @watch.user_id
    click_on "Create Watch"

    assert_text "Watch was successfully created"
    click_on "Back"
  end

  test "updating a Watch" do
    visit watches_url
    click_on "Edit", match: :first

    fill_in "Hostid", with: @watch.hostId
    fill_in "User", with: @watch.user_id
    click_on "Update Watch"

    assert_text "Watch was successfully updated"
    click_on "Back"
  end

  test "destroying a Watch" do
    visit watches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Watch was successfully destroyed"
  end
end
