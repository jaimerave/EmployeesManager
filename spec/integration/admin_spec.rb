# encoding: UTF-8
require 'spec_helper'

describe "Admin" do
  before do
    Factory(:admin_user)
    stub_twitter_calls
  end

  it "should be able to login" do
    login_admin
    page.should have_content("Dashboard")
  end

  it "should show an error if the email or password is invalid" do
    visit root_path
    page.should have_content("Email")
    page.should have_content("Password")
    fill_in "admin_user_email", with: "admin@example.com"
    fill_in "admin_user_password", with: ""
    click_on "Login"
    page.should have_content("Invalid email or password")
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
end