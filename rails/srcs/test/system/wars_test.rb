require "application_system_test_case"

class WarsTest < ApplicationSystemTestCase
  setup do
    @war = wars(:one)
  end

  test "visiting the index" do
    visit wars_url
    assert_selector "h1", text: "Wars"
  end

  test "creating a War" do
    visit wars_url
    click_on "New War"

    fill_in "End date", with: @war.end_date
    fill_in "Max unanswered call", with: @war.max_unanswered_call
    fill_in "Prize in points", with: @war.prize_in_points
    fill_in "Start date", with: @war.start_date
    fill_in "Status", with: @war.status
    fill_in "Winner", with: @war.winner_id
    click_on "Create War"

    assert_text "War was successfully created"
    click_on "Back"
  end

  test "updating a War" do
    visit wars_url
    click_on "Edit", match: :first

    fill_in "End date", with: @war.end_date
    fill_in "Max unanswered call", with: @war.max_unanswered_call
    fill_in "Prize in points", with: @war.prize_in_points
    fill_in "Start date", with: @war.start_date
    fill_in "Status", with: @war.status
    fill_in "Winner", with: @war.winner_id
    click_on "Update War"

    assert_text "War was successfully updated"
    click_on "Back"
  end

  test "destroying a War" do
    visit wars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "War was successfully destroyed"
  end
end
