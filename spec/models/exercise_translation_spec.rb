require "rails_helper"

RSpec.describe ExerciseTranslation, type: :model do
  subject(:translation) { build(:exercise_translation) }

  before do
    create(:exercise_translation)
  end

  it { is_expected.to belong_to(:exercise) }
  it { is_expected.to validate_presence_of(:exercise) }
  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_inclusion_of(:locale).in_array(%w[en ru]) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_length_of(:description).is_at_most(2000) }
  it { is_expected.to validate_uniqueness_of(:locale).scoped_to(:exercise_id) }

  it "normalizes name before validation" do
    translation.name = "  Bench Press  "
    translation.valid?

    expect(translation.name).to eq("Bench Press")
  end

  it "normalizes description before validation" do
    translation.description = "  Flat bench press  "
    translation.valid?

    expect(translation.description).to eq("Flat bench press")
  end

  it "normalizes synonyms into unique stripped values" do
    translation.synonyms = [ "  chest ", "chest", "", " upper body " ]
    translation.valid?

    expect(translation.synonyms).to eq([ "chest", "upper body" ])
  end

  describe "#synonyms_csv" do
    it "returns comma-separated synonyms" do
      translation.synonyms = [ "bench", "barbell press" ]

      expect(translation.synonyms_csv).to eq("bench, barbell press")
    end
  end

  describe "#synonyms_csv=" do
    before do
      translation.synonyms_csv = " bench press, chest press , , flat press "
      translation.valid?
    end

    it "parses and normalizes comma-separated synonyms" do
      expect(translation.synonyms).to eq([ "bench press", "chest press", "flat press" ])
    end
  end
end
