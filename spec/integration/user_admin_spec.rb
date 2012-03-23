# encoding: UTF-8
require 'spec_helper'

describe "Admins" do
  before do
    AdminUser.destroy_all
    Factory(:admin_user)
    stub_twitter_calls
  end

  it "should be able to create users" do
    login_admin
    click_on "Users"
    click_on "New User"
    fill_in "user_name", with: "Jaime Andres"
    fill_in "user_email", with: "jaimerave@gmail.com"
    fill_in "user_phone", with: "3407009"
    fill_in "user_mobile", with: "3003160361"
    fill_in "user_twitter", with: "@jaimerave"
    fill_in "user_facebook", with: "facebook.com/jaimerave"
    click_on "Create User"
    page.should have_content("User Details")
  end

  it "should see an error if invalid attributes" do
    login_admin
    click_on "Users"
    click_on "New User"
    fill_in "user_name", with: "Jaime Andres"
    fill_in "user_email", with: "jaimerave@gmail.com"
    fill_in "user_phone", with: "3407009"
    fill_in "user_mobile", with: "3003160361"
    fill_in "user_twitter", with: "@jaimerave12345"
    fill_in "user_facebook", with: "facebook.com/jaimerave"
    click_on "Create User"
    page.should have_content("New User")
    page.should have_content("does not exists")
  end

  before do
    Factory(:user)
  end

  it "should be able to see the list of users" do
    login_admin
    click_on "Users"
    page.should have_content("@JaimeRave")
  end

  it "should be able to see the user profile" do
    login_admin
    click_on "Users"
    click_on "View"
    page.should have_content("User Details")
    page.should have_content("@JaimeRave")
  end
end