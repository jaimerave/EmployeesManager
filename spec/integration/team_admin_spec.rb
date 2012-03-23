# encoding: UTF-8
require 'spec_helper'

describe "Admins" do
  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  before do
    AdminUser.destroy_all
    User.destroy_all
    stub_twitter_calls
    Factory(:user)
  end

  let(:user) { Factory.create(:admin_user) }

  it "should be able to create Teams", js: true do
    WebMock.disable!
    as_admin(user) do
      visit new_admin_team_path
      fill_in "Name", with: "Elite Team"
      click_on "Add New Team Member"
      page.select("Jaime Rave")
      click_on("Create Team")
      page.should have_content("Team #")
    end
    WebMock.enable!
  end

  it "should not be able to create Teams without members", js: true do
    WebMock.disable!
    as_admin(user) do
      visit new_admin_team_path
      fill_in "Name", with: "Elite Team"
      click_on("Create Team")
      page.should have_content("Must have at least one member")
    end
    WebMock.enable!
  end
end