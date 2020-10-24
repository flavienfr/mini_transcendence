require "application_system_test_case"

class AchievementsTest < ApplicationSystemTestCase
  setup do
    @achievement = achievements(:one)
  end

  test "visiting the index" do
    visit achievements_url
    assert_selector "h1", text: "Achievements"
  end

  test "creating a Achievement" do
    visit achievements_url
    click_on "New Achievement"

    fill_in "Description", with: @achievement.description
    fill_in "Name", with: @achievement.name
    fill_in "Points", with: @achievement.points
    click_on "Create Achievement"

    assert_text "Achievement was successfully created"
    click_on "Back"
  end

  test "updating a Achievement" do
    visit achievements_url
    click_on "Edit", match: :first

    fill_in "Description", with: @achievement.description
    fill_in "Name", with: @achievement.name
    fill_in "Points", with: @achievement.points
    click_on "Update Achievement"

    assert_text "Achievement was successfully updated"
    click_on "Back"
  end

  test "destroying a Achievement" do
    visit achievements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Achievement was successfully destroyed"
  end
end
