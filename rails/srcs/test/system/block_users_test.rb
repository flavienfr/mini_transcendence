require "application_system_test_case"

class BlockUsersTest < ApplicationSystemTestCase
  setup do
    @block_user = block_users(:one)
  end

  test "visiting the index" do
    visit block_users_url
    assert_selector "h1", text: "Block Users"
  end

  test "creating a Block user" do
    visit block_users_url
    click_on "New Block User"

    fill_in "Block user", with: @block_user.block_user_id
    fill_in "Status", with: @block_user.status
    fill_in "User", with: @block_user.user_id
    click_on "Create Block user"

    assert_text "Block user was successfully created"
    click_on "Back"
  end

  test "updating a Block user" do
    visit block_users_url
    click_on "Edit", match: :first

    fill_in "Block user", with: @block_user.block_user_id
    fill_in "Status", with: @block_user.status
    fill_in "User", with: @block_user.user_id
    click_on "Update Block user"

    assert_text "Block user was successfully updated"
    click_on "Back"
  end

  test "destroying a Block user" do
    visit block_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Block user was successfully destroyed"
  end
end
