require "application_system_test_case"

class WarTimesTest < ApplicationSystemTestCase
  setup do
    @war_time = war_times(:one)
  end

  test "visiting the index" do
    visit war_times_url
    assert_selector "h1", text: "War Times"
  end

  test "creating a War time" do
    visit war_times_url
    click_on "New War Time"

    fill_in "A", with: @war_time.a
    fill_in "B", with: @war_time.b
    fill_in "End date", with: @war_time.end_date
    fill_in "Nb unanswered call a", with: @war_time.nb_unanswered_call_a
    fill_in "Nb unanswered call b", with: @war_time.nb_unanswered_call_b
    check "Ongoing match" if @war_time.ongoing_match
    fill_in "Start date", with: @war_time.start_date
    fill_in "Status", with: @war_time.status
    fill_in "War", with: @war_time.war_id
    click_on "Create War time"

    assert_text "War time was successfully created"
    click_on "Back"
  end

  test "updating a War time" do
    visit war_times_url
    click_on "Edit", match: :first

    fill_in "A", with: @war_time.a
    fill_in "B", with: @war_time.b
    fill_in "End date", with: @war_time.end_date
    fill_in "Nb unanswered call a", with: @war_time.nb_unanswered_call_a
    fill_in "Nb unanswered call b", with: @war_time.nb_unanswered_call_b
    check "Ongoing match" if @war_time.ongoing_match
    fill_in "Start date", with: @war_time.start_date
    fill_in "Status", with: @war_time.status
    fill_in "War", with: @war_time.war_id
    click_on "Update War time"

    assert_text "War time was successfully updated"
    click_on "Back"
  end

  test "destroying a War time" do
    visit war_times_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "War time was successfully destroyed"
  end
end
