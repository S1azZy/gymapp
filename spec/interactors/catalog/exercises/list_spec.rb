require "rails_helper"

RSpec.describe Catalog::Exercises::List do
  subject(:result) { described_class.call(locale: "en", filters:) }

  let(:filters) { {} }

  before do
    seed_catalog_fixture
  end

  it "returns active exercises" do
    expect(result).to be_success
    expect(result.value!.pluck(:key)).to include("barbell_bench_press")
  end

  context "with a query filter" do
    let(:filters) { { query: "chest press" } }

    it "matches localized synonyms" do
      expect(result.value!.pluck(:key)).to contain_exactly("barbell_bench_press")
    end
  end

  context "with a tag filter" do
    let(:filters) { { tag_id: Tag.find_by!(key: "compound").id } }

    it "filters by tag" do
      expect(result.value!.pluck(:key)).to contain_exactly("barbell_bench_press")
    end
  end

  def seed_catalog_fixture
    body_part = create(:body_part, key: "upper_body")
    create(:body_part_translation, body_part:, locale: "en", name: "Upper body")

    muscle_group = create(:muscle_group, key: "chest")
    create(:muscle_group_translation, muscle_group:, locale: "en", name: "Chest")

    equipment_type = create(:equipment_type, key: "barbell")
    create(:equipment_type_translation, equipment_type:, locale: "en", name: "Barbell")

    tag = create(:tag, key: "compound")
    create(:tag_translation, tag:, locale: "en", name: "Compound")

    create(:exercise, key: "barbell_bench_press", body_part:, muscle_group:, equipment_type:).tap do |record|
      record.tags << tag
      create(:exercise_translation, exercise: record, locale: "en", name: "Bench Press", synonyms: [ "chest press" ])
    end
  end
end
