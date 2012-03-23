# encoding: UTF-8
require 'spec_helper'

describe "Admin" do
  before do
    AdminUser.destroy_all
    Factory(:admin_user)
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
end