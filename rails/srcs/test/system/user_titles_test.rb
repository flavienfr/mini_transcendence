require "application_system_test_case"

class UserTitlesTest < ApplicationSystemTestCase
  setup do
    @user_title = user_titles(:one)
  end

  test "visiting the index" do
    visit user_titles_url
    assert_selector "h1", text: "User Titles"
  end

  test "creating a User title" do
    visit user_titles_url
    click_on "New User Title"

    fill_in "Status", with: @user_title.status
    fill_in "Title", with: @user_title.title
    fill_in "Tournament", with: @user_title.tournament_id
    fill_in "User id", with: @user_title.user_id_id
    click_on "Create User title"

    assert_text "User title was successfully created"
    click_on "Back"
  end

  test "updating a User title" do
    visit user_titles_url
    click_on "Edit", match: :first

    fill_in "Status", with: @user_title.status
    fill_in "Title", with: @user_title.title
    fill_in "Tournament", with: @user_title.tournament_id
    fill_in "User id", with: @user_title.user_id_id
    click_on "Update User title"

    assert_text "User title was successfully updated"
    click_on "Back"
  end

  test "destroying a User title" do
    visit user_titles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User title was successfully destroyed"
  end
end
