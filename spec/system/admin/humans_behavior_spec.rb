require 'rails_helper'

describe "interaction for Admin::HumansController", type: :feature do
  include HotGlue::ControllerHelper
  #HOTGLUE-SAVESTART

  #HOTGLUE-END
  
  
  let!(:human1) {create(:human , email: FFaker::Internet.email, 
      name: FFaker::Movie.title, 
      is_admin: !!rand(2).floor )}
   

  describe "index" do
    it "should show me the list" do
      visit admin_humans_path
      expect(page).to have_content(human1.email)
      expect(page).to have_content(human1.name)
      expect(page).to have_content(human1.is_admin)
    end
  end

  describe "new & create" do
    it "should create a new Human" do
      visit admin_humans_path
      click_link "New Human"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Human")]')

      new_email = 'new_test-email@nowhere.com' 
      find("[name='human[email]']").fill_in(with: new_email)
      new_name = 'new_test-email@nowhere.com' 
      find("[name='human[name]']").fill_in(with: new_name)
     new_is_admin = rand(2).floor 
     find("[name='human[is_admin]'][value='#{new_is_admin}']").choose
      click_button "Save"
      expect(page).to have_content("Successfully created")
      expect(page).to have_content(new_email)
      expect(page).to have_content(new_name)
      expect(page).to have_content(new_is_admin)
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit admin_humans_path
      find("a.edit-human-button[href='/admin/humans/#{human1.id}/edit']").click

      expect(page).to have_content("Editing #{human1.name.squish || "(no name)"}")
      new_email = 'new_test-email@nowhere.com' 
      find("[name='human[email]']").fill_in(with: new_email)
      new_name = FFaker::Lorem.paragraphs(1).join 
      find("input[name='human[name]']").fill_in(with: new_name)
     new_is_admin = rand(2).floor 
     find("[name='human[is_admin]'][value='#{new_is_admin}']").choose
      click_button "Save"
      within("turbo-frame#human__#{human1.id} ") do
        expect(page).to have_content(new_email)
        expect(page).to have_content(new_name)
      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit admin_humans_path
      accept_alert do
        find("form[action='/admin/humans/#{human1.id}'] > input.delete-human-button").click
      end
      expect(page).to_not have_content(human1.name)
      expect(Human.where(id: human1.id).count).to eq(0)
    end
  end
end

