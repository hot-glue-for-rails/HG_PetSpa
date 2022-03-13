require "rails_helper"


describe "Welcome screen", type: :feature do
  describe "for someone not logged in" do

    it "should redirect me to the login page" do
      visit "/"

    end

  end

  describe "for someone logged in" do
    it "should redirect me to the dashboard" do
      visit "/"
    end
  end
end