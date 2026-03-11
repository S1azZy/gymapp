require "rails_helper"

RSpec.describe "Admin reference catalog flow", type: :system do
  let(:admin) { create(:user, :admin, email: "admin@example.com") }
  let(:member) { create(:user, email: "member@example.com") }

  describe "admin dashboard" do
    before do
      sign_in_as(admin)
      visit admin_dashboard_path
    end

    it "shows resource counts" do
      expect(page).to have_text("0 records", count: 5)
    end
  end

  describe "member browsing a newly created admin exercise" do
    before do
      sign_in_as(admin)
      create_reference_dataset_from_admin
      sign_out
      sign_in_as(member)
      visit exercises_path
    end

    it "renders the exercise in the catalog" do
      expect(page).to have_text("Bench Press")
      expect(page).to have_text("Chest press")
    end

    it "opens the exercise detail page" do
      click_link "Bench Press"

      expect(page).to have_text("Classic upper-body pressing movement.")
      expect(page).to have_text("Compound")
    end

    it "updates the admin dashboard counts" do
      sign_out
      sign_in_as(admin)
      visit admin_dashboard_path

      expect(page).to have_text("1 record", count: 5)
    end
  end

  it "keeps inactive exercises out of the member catalog" do
    create_catalog_exercise(key: "active_press", name: "Active Press", active: true)
    create_catalog_exercise(key: "inactive_press", name: "Inactive Press", active: false)

    sign_in_as(member)
    visit exercises_path

    expect(page).to have_text("Active Press")
    expect(page).not_to have_text("Inactive Press")
  end

  def create_reference_dataset_from_admin
    create_body_part
    create_muscle_group
    create_equipment_type
    create_tag
    create_exercise
  end

  def create_body_part
    visit new_admin_body_part_path
    fill_in "body_part_key", with: "upper_body"
    fill_in "body_part_position", with: "10"
    fill_in "body_part_translations_en_name", with: "Upper body"
    fill_in "body_part_translations_ru_name", with: "Верх тела"
    click_button "Save"
  end

  def create_muscle_group
    visit new_admin_muscle_group_path
    fill_in "muscle_group_key", with: "chest"
    fill_in "muscle_group_position", with: "10"
    fill_in "muscle_group_translations_en_name", with: "Chest"
    fill_in "muscle_group_translations_ru_name", with: "Грудь"
    click_button "Save"
  end

  def create_equipment_type
    visit new_admin_equipment_type_path
    fill_in "equipment_type_key", with: "barbell"
    fill_in "equipment_type_position", with: "10"
    fill_in "equipment_type_translations_en_name", with: "Barbell"
    fill_in "equipment_type_translations_ru_name", with: "Штанга"
    click_button "Save"
  end

  def create_tag
    visit new_admin_tag_path
    fill_in "tag_key", with: "compound"
    fill_in "tag_position", with: "10"
    fill_in "tag_translations_en_name", with: "Compound"
    fill_in "tag_translations_ru_name", with: "Базовое"
    click_button "Save"
  end

  def create_exercise
    visit new_admin_exercise_path
    fill_in "exercise_key", with: "barbell_bench_press"
    select "Upper body", from: "Body part"
    select "Chest", from: "Muscle group"
    select "Barbell", from: "Equipment type"
    check "Compound"
    fill_in "exercise_translations_en_name", with: "Bench Press"
    fill_in "exercise_translations_en_description", with: "Classic upper-body pressing movement."
    fill_in "exercise_translations_en_synonyms_csv", with: "Chest press, flat bench"
    fill_in "exercise_translations_ru_name", with: "Жим лежа"
    fill_in "exercise_translations_ru_description", with: "Классическое жимовое упражнение на верх тела."
    fill_in "exercise_translations_ru_synonyms_csv", with: "Жим штанги лежа"
    click_button "Save"
  end

  def create_catalog_exercise(key:, name:, active:)
    body_part = create(:body_part, key: "#{key}_body_part", position: 10)
    create(:body_part_translation, body_part:, locale: "en", name: "Upper body")

    muscle_group = create(:muscle_group, key: "#{key}_muscle_group", position: 10)
    create(:muscle_group_translation, muscle_group:, locale: "en", name: "Chest")

    equipment_type = create(:equipment_type, key: "#{key}_equipment_type", position: 10)
    create(:equipment_type_translation, equipment_type:, locale: "en", name: "Barbell")

    tag = create(:tag, key: "#{key}_tag", position: 10)
    create(:tag_translation, tag:, locale: "en", name: "Compound")

    create(
      :exercise,
      key:,
      active:,
      body_part:,
      muscle_group:,
      equipment_type:
    ).tap do |exercise|
      exercise.tags << tag
      create(:exercise_translation, exercise:, locale: "en", name:)
    end
  end
end
