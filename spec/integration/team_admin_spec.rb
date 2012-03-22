# encoding: UTF-8
require 'spec_helper'

describe "Admins" do
  before(:each) do
    Factory(:admin_user)
    p AdminUser.all
    Factory(:user)
    stub_twitter_calls
  end

  it "should be able to create Teams", js: true do
    WebMock.disable!
    login_admin
    WebMock.enable!
    click_on "Teams"
    click_on "New Team"
    fill_in "Name", with: "Elite Team"
    click_on "Add New Team Member"
    page.select("Jaime Rave")
    click_on("Create Team")
    page.should have_content("Team #1")
  end
end