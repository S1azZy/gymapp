# rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
require "rails_helper"

RSpec.describe "Workout templates", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
    sign_in_as(user)
  end

  it "allows a user to create, update, and delete a workout template" do
    visit dashboard_path
    within(".app-nav") do
      click_link "Templates"
    end
    click_link "New template"

    fill_in "Name", with: "Upper body"
    fill_in "Notes", with: "Main strength day"
    check "Active"
    click_button "Save"

    expect(page).to have_current_path(workout_template_path(WorkoutTemplate.order(:created_at).last))
    expect(page).to have_content("Upper body")
    expect(page).to have_content("Main strength day")

    click_link "Edit"
    fill_in "Name", with: "Upper body A"
    uncheck "Active"
    click_button "Save"

    expect(page).to have_content("Upper body A")
    expect(page).to have_content("Inactive")

    click_button "Delete"

    expect(page).to have_current_path(workout_templates_path)
    expect(page).to have_content("Template deleted.")
  end
end
# rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
