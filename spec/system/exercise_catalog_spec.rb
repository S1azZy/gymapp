require "rails_helper"

RSpec.describe "Exercise catalog", type: :system do
  before do
    seed_catalog_fixture
    sign_up_as("catalog-user@example.com")
    click_link "Exercises", match: :first
  end

  it "shows the exercise in the catalog list" do
    expect(page).to have_text("Bench Press")
  end

  it "filters the catalog by search" do
    fill_in "Search", with: "chest press"
    click_button "Apply filters"

    expect(page).to have_text("Bench Press")
  end

  it "opens the exercise detail page" do
    click_link "Bench Press"

    expect(page).to have_text("Flat press")
    expect(page).to have_text("Compound")
  end

  def seed_catalog_fixture
    body_part = create(:body_part, key: "upper_body", position: 10)
    create(:body_part_translation, body_part:, locale: "en", name: "Upper body")

    muscle_group = create(:muscle_group, key: "chest", position: 10)
    create(:muscle_group_translation, muscle_group:, locale: "en", name: "Chest")

    equipment_type = create(:equipment_type, key: "barbell", position: 10)
    create(:equipment_type_translation, equipment_type:, locale: "en", name: "Barbell")

    tag = create(:tag, key: "compound", position: 10)
    create(:tag_translation, tag:, locale: "en", name: "Compound")

    create(:exercise, key: "barbell_bench_press", body_part:, muscle_group:, equipment_type:).tap do |record|
      record.tags << tag
      create(:exercise_translation, exercise: record, locale: "en", name: "Bench Press", description: "Flat press", synonyms: [ "bench", "chest press" ])
      create(:exercise_translation, exercise: record, locale: "ru", name: "Жим лежа", description: "Жим штанги лежа", synonyms: [ "жим" ])
    end
  end

  def sign_up_as(email)
    visit root_path
    click_link "Sign up", match: :first
    fill_in "Email", with: email
    fill_in "Password", with: "supersecure123"
    fill_in "Confirm password", with: "supersecure123"
    click_button "Create account"
  end
end
