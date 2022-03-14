require 'rails_helper'

describe "interaction for Dashboard::AppointmentsController", type: :feature do
  include HotGlue::ControllerHelper
  #HOTGLUE-SAVESTART
  #HOTGLUE-END
  let(:current_human) {create(:human)}
  let!(:pet1) {create(:pet)}
  let!(:appointment1) {create(:appointment, human: current_human , when_at: DateTime.current + rand(1000).seconds, 
      pet: pet1 )}
   
  before(:each) do
    login_as(current_human)
  end 

  describe "index" do
    it "should show me the list" do
      visit dashboard_appointments_path
      expect(page).to have_content(appointment1.when_at.in_time_zone(current_timezone).strftime('%m/%d/%Y @ %l:%M %p ').gsub('  ', ' ') + timezonize(current_timezone)  )

    end
  end

  describe "new & create" do
    it "should create a new Appointment" do
      visit dashboard_appointments_path
      click_link "New Appointment"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Appointment")]')

      new_when_at = DateTime.current + (rand(100).days) 
      find("[name='appointment[when_at]']").fill_in(with: new_when_at)
      pet_id_selector = find("[name='appointment[pet_id]']").click 
      pet_id_selector.first('option', text: pet1.name).select_option
      click_button "Save"
      expect(page).to have_content("Successfully created")
      
    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit dashboard_appointments_path
      find("a.edit-appointment-button[href='/dashboard/appointments/#{appointment1.id}/edit']").click

      expect(page).to have_content("Editing #{appointment1.name.squish || "(no name)"}")
      new_when_at = DateTime.current + 1.day 
      find("[name='appointment[when_at]']").fill_in(with: new_when_at)

      click_button "Save"
      within("turbo-frame#appointment__#{appointment1.id} ") do

      end
    end
  end 

  describe "destroy" do
    it "should destroy" do
      visit dashboard_appointments_path
      accept_alert do
        find("form[action='/dashboard/appointments/#{appointment1.id}'] > input.delete-appointment-button").click
      end
      expect(page).to_not have_content(appointment1.name)
      expect(Appointment.where(id: appointment1.id).count).to eq(0)
    end
  end
end

