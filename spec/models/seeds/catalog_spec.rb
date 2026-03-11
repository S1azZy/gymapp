require "rails_helper"

module Seeds
  module Catalog
  end
end

RSpec.describe Seeds::Catalog do
  let(:seed_file) { Rails.root.join("db/seeds.rb") }
  let(:catalog_file) { Rails.root.join("db/seeds/catalog.rb") }

  def load_seeds
    silence_warnings { load seed_file }
  end

  def load_catalog_definitions
    silence_warnings { load catalog_file }
  end

  def expected_body_parts_count
    load_catalog_definitions
    described_class::BODY_PARTS.size
  end

  def expected_muscle_groups_count
    load_catalog_definitions
    described_class::MUSCLE_GROUPS.size
  end

  def expected_equipment_types_count
    load_catalog_definitions
    described_class::EQUIPMENT_TYPES.size
  end

  def expected_tags_count
    load_catalog_definitions
    described_class::TAGS.size
  end

  def expected_exercises_count
    load_catalog_definitions
    described_class::EXERCISES.size
  end

  def expected_exercise_tags_count
    load_catalog_definitions
    described_class::EXERCISES.sum { |row| row.fetch(:tag_keys).size }
  end

  def expected_exercise_translations_count
    load_catalog_definitions
    described_class::EXERCISES.sum { |row| row.fetch(:translations).size }
  end

  it "creates the baseline reference and exercise dataset" do
    expect { load_seeds }.to change(BodyPart, :count).by(expected_body_parts_count)
      .and change(MuscleGroup, :count).by(expected_muscle_groups_count)
      .and change(EquipmentType, :count).by(expected_equipment_types_count)
      .and change(Tag, :count).by(expected_tags_count)
      .and change(Exercise, :count).by(expected_exercises_count)
      .and change(ExerciseTag, :count).by(expected_exercise_tags_count)
      .and change(ExerciseTranslation, :count).by(expected_exercise_translations_count)
  end

  context "when the catalog was already seeded" do
    before do
      load_seeds
    end

    it "does not duplicate body parts" do
      expect { load_seeds }.not_to change(BodyPart, :count)
    end

    it "does not duplicate muscle groups" do
      expect { load_seeds }.not_to change(MuscleGroup, :count)
    end

    it "does not duplicate equipment types" do
      expect { load_seeds }.not_to change(EquipmentType, :count)
    end

    it "does not duplicate tags" do
      expect { load_seeds }.not_to change(Tag, :count)
    end

    it "does not duplicate exercises" do
      expect { load_seeds }.not_to change(Exercise, :count)
    end

    it "does not duplicate exercise tags" do
      expect { load_seeds }.not_to change(ExerciseTag, :count)
    end

    it "does not duplicate exercise translations" do
      expect { load_seeds }.not_to change(ExerciseTranslation, :count)
    end

    it "resolves body part through stable keys" do
      bench_press = Exercise.find_by!(key: "barbell_bench_press")

      expect(bench_press.body_part.key).to eq("upper_body")
    end

    it "resolves muscle group through stable keys" do
      bench_press = Exercise.find_by!(key: "barbell_bench_press")

      expect(bench_press.muscle_group.key).to eq("chest")
    end

    it "resolves equipment type through stable keys" do
      bench_press = Exercise.find_by!(key: "barbell_bench_press")

      expect(bench_press.equipment_type.key).to eq("barbell")
    end

    it "assigns exercise tags by key" do
      bench_press = Exercise.find_by!(key: "barbell_bench_press")

      expect(bench_press.tags.order(:key).pluck(:key)).to include("compound", "horizontal_push", "push")
    end

    it "persists exercise translations for both locales" do
      bench_press = Exercise.find_by!(key: "barbell_bench_press")

      expect(bench_press.translation_for(:en)&.name).to eq("Barbell bench press")
      expect(bench_press.translation_for(:ru)&.name).to eq("Жим штанги лежа")
    end
  end
end
