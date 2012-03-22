require 'spec_helper'

describe User do
  before do
    stub_twitter_calls
  end

  it "should create a new user given valid attributes" do
    Factory.build(:user).should be_valid
  end

  it "should have valid name" do
    Factory.build(:user, name: "").should_not be_valid
  end  

  it "should have valid email" do
    Factory.build(:user, email: "jaimerave--").should_not be_valid
    Factory.build(:user, email: "jaimerave@gmail").should_not be_valid
  end

  it "should have valid mobile number" do
    Factory.build(:user, mobile: "").should_not be_valid
    Factory.build(:user, mobile: "344kkkss").should_not be_valid
    Factory.build(:user, mobile: "344").should_not be_valid
    Factory.build(:user, mobile: "+57 300 316 0361").should be_valid
    Factory.build(:user, mobile: "57 300 316 0361").should be_valid
    Factory.build(:user, mobile: "+573003160361").should be_valid
  end

  it "should have valid landline number" do
    Factory.build(:user, phone: "").should_not be_valid
    Factory.build(:user, phone: "344kkkss").should_not be_valid
    Factory.build(:user, phone: "344").should_not be_valid
    Factory.build(:user, phone: "+57 5 340 0868").should be_valid
    Factory.build(:user, phone: "57 5 3400868").should be_valid
    Factory.build(:user, phone: "+5753400868").should be_valid
  end

  it "should have a valid twitter" do
    Factory.build(:user, twitter: "").should_not be_valid
    Factory.build(:user, twitter: "jaimerave12345").should_not be_valid
    Factory.build(:user, twitter: "jaimerave").should be_valid
    Factory.build(:user, twitter: "JaimeRave").should be_valid
    Factory.build(:user, twitter: "twitter.com/jaimerave").should be_valid
    Factory.build(:user, twitter: "https://twitter.com/#!/jaimerave").should be_valid
  end

  it "should have a valid facebook" do
    Factory.build(:user, twitter: "").should_not be_valid
    Factory.build(:user, twitter: "pajarito.com").should_not be_valid
  end
end