require "application_system_test_case"

class UserProfilesTest < ApplicationSystemTestCase
  setup do
    @user_profile = user_profiles(:one)
  end

  test "visiting the index" do
    visit user_profiles_url
    assert_selector "h1", text: "User Profiles"
  end

  test "creating a User profile" do
    visit user_profiles_url
    click_on "New User Profile"

    fill_in "Address", with: @user_profile.address
    fill_in "Applicant type", with: @user_profile.applicant_type
    fill_in "Department", with: @user_profile.department
    fill_in "Gender", with: @user_profile.gender
    fill_in "Mobile no", with: @user_profile.mobile_no
    fill_in "Name", with: @user_profile.name
    fill_in "Unique", with: @user_profile.unique_id
    click_on "Create User profile"

    assert_text "User profile was successfully created"
    click_on "Back"
  end

  test "updating a User profile" do
    visit user_profiles_url
    click_on "Edit", match: :first

    fill_in "Address", with: @user_profile.address
    fill_in "Applicant type", with: @user_profile.applicant_type
    fill_in "Department", with: @user_profile.department
    fill_in "Gender", with: @user_profile.gender
    fill_in "Mobile no", with: @user_profile.mobile_no
    fill_in "Name", with: @user_profile.name
    fill_in "Unique", with: @user_profile.unique_id
    click_on "Update User profile"

    assert_text "User profile was successfully updated"
    click_on "Back"
  end

  test "destroying a User profile" do
    visit user_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User profile was successfully destroyed"
  end
end
