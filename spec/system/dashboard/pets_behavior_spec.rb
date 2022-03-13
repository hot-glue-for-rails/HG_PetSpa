require 'rails_helper'

describe "interaction for Dashboard::PetsController", type: :feature do
  include HotGlue::ControllerHelper
  #HOTGLUE-SAVESTART
  #HOTGLUE-END
  let(:current_human) {create(:human)}
  
  let!(:pet1) {create(:pet, human: current_human , name: FFaker::Movie.title )}
   
  before(:each) do
    login_as(current_human)
  end 

  describe "index" do
    it "should show me the list" do
      visit dashboard_pets_path
      expect(page).to have_content(pet1.name)
    end
  end

  describe "new & create" do
    it "should create a new Pet" do
      visit dashboard_pets_path
      click_link "New Pet"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Pet")]')

      new_name = 'new_test-email@nowhere.com' 
      find("[name='pet[name]']").fill_in(with: new_name)
      click_button "Save"
      expect(page).to have_content("Successfully created")
      expect(page).to have_content(new_name)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit dashboard_pets_path
      find("a.edit-pet-button[href='/dashboard/pets/#{pet1.id}/edit']").click

      expect(page).to have_content("Editing #{pet1.name.squish || "(no name)"}")
      new_name = FFaker::Lorem.paragraphs(1).join 
      find("input[name='pet[name]']").fill_in(with: new_name)
      click_button "Save"
      within("turbo-frame#pet__#{pet1.id} ") do
        expect(page).to have_content(new_name)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit dashboard_pets_path
      accept_alert do
        find("form[action='/dashboard/pets/#{pet1.id}'] > input.delete-pet-button").click
      end
      expect(page).to_not have_content(pet1.name)
      expect(Pet.where(id: pet1.id).count).to eq(0)
    end
  end
end

