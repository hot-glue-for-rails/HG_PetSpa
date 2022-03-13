require "rails_helper"


describe "Welcome screen", type: :feature do
  describe "for someone not logged in" do

    it "should redirect me to the login page" do
      visit "/"
      expect(page).to have_content( "Log in")
    end

  end

  describe "for someone logged in" do

    let(:current_human) {create(:human)}

    let!(:pet1) {create(:pet, human: current_human , name: FFaker::Movie.title )}

    before(:each) do
      login_as(current_human)
    end


    it "should redirect me to the dashboard" do
      visit "/"
      expect(page).to have_content "Pets"

    end
  end
end