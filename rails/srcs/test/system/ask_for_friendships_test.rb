require "application_system_test_case"

class AskForFriendshipsTest < ApplicationSystemTestCase
  setup do
    @ask_for_friendship = ask_for_friendships(:one)
  end

  test "visiting the index" do
    visit ask_for_friendships_url
    assert_selector "h1", text: "Ask For Friendships"
  end

  test "creating a Ask for friendship" do
    visit ask_for_friendships_url
    click_on "New Ask For Friendship"

    fill_in "Friendship", with: @ask_for_friendship.friendship_id
    fill_in "From user", with: @ask_for_friendship.from_user_id
    fill_in "Status", with: @ask_for_friendship.status
    fill_in "To user", with: @ask_for_friendship.to_user_id
    click_on "Create Ask for friendship"

    assert_text "Ask for friendship was successfully created"
    click_on "Back"
  end

  test "updating a Ask for friendship" do
    visit ask_for_friendships_url
    click_on "Edit", match: :first

    fill_in "Friendship", with: @ask_for_friendship.friendship_id
    fill_in "From user", with: @ask_for_friendship.from_user_id
    fill_in "Status", with: @ask_for_friendship.status
    fill_in "To user", with: @ask_for_friendship.to_user_id
    click_on "Update Ask for friendship"

    assert_text "Ask for friendship was successfully updated"
    click_on "Back"
  end

  test "destroying a Ask for friendship" do
    visit ask_for_friendships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ask for friendship was successfully destroyed"
  end
end
