require "application_system_test_case"

class UserAchievementsTest < ApplicationSystemTestCase
  setup do
    @user_achievement = user_achievements(:one)
  end

  test "visiting the index" do
    visit user_achievements_url
    assert_selector "h1", text: "User Achievements"
  end

  test "creating a User achievement" do
    visit user_achievements_url
    click_on "New User Achievement"

    fill_in "Achievement", with: @user_achievement.achievement_id
    fill_in "Status", with: @user_achievement.status
    fill_in "User", with: @user_achievement.user_id
    click_on "Create User achievement"

    assert_text "User achievement was successfully created"
    click_on "Back"
  end

  test "updating a User achievement" do
    visit user_achievements_url
    click_on "Edit", match: :first

    fill_in "Achievement", with: @user_achievement.achievement_id
    fill_in "Status", with: @user_achievement.status
    fill_in "User", with: @user_achievement.user_id
    click_on "Update User achievement"

    assert_text "User achievement was successfully updated"
    click_on "Back"
  end

  test "destroying a User achievement" do
    visit user_achievements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User achievement was successfully destroyed"
  end
end
