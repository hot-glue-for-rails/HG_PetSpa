require "rails_helper"


describe "Welcome screen" do
  describe "for someone not logged in" do
    visit "/"

  end

  describe "for someone logged in" do
    visit "/"
  end
end