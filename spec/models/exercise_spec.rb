require "rails_helper"

RSpec.describe Exercise, type: :model do
  subject(:exercise) { build(:exercise) }

  it { is_expected.to belong_to(:body_part) }
  it { is_expected.to belong_to(:muscle_group) }
  it { is_expected.to belong_to(:equipment_type) }
  it { is_expected.to have_many(:exercise_tags).dependent(:destroy) }
  it { is_expected.to have_many(:workout_template_exercises).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:tags).through(:exercise_tags) }
  it { is_expected.to have_many(:exercise_translations).dependent(:destroy) }
  it { is_expected.to have_many(:workout_templates).through(:workout_template_exercises) }
  it { is_expected.to validate_presence_of(:body_part) }
  it { is_expected.to validate_presence_of(:muscle_group) }
  it { is_expected.to validate_presence_of(:equipment_type) }

  it_behaves_like "keyed catalog entity", :exercise, positioned: false

  describe "#translation_for" do
    subject(:translation_for_locale) { exercise.translation_for(requested_locale) }

    let(:requested_locale) { :ru }

    before do
      exercise.save!
      create(:exercise_translation, exercise:, locale: "en", name: "Bench Press")
      create(:exercise_translation, exercise:, locale: "ru", name: "Жим лежа")
    end

    it "returns translation for provided locale" do
      expect(translation_for_locale&.name).to eq("Жим лежа")
    end
  end

  describe "#localized_name" do
    subject(:localized_name) { exercise.localized_name(requested_locale) }

    let(:requested_locale) { :en }

    before do
      exercise.save!
      create(:exercise_translation, exercise:, locale: "en", name: "Bench Press")
    end

    it "returns localized name from translation" do
      expect(localized_name).to eq("Bench Press")
    end
  end
end
