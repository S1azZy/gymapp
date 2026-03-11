# rubocop:disable RSpec/MultipleExpectations
require "rails_helper"

RSpec.describe WorkoutTemplates::Upsert, type: :interactor do
  describe ".call" do
    subject(:result) do
      described_class.call(
        workout_template:,
        workout_template_attributes: attributes
      )
    end

    let(:user) { create(:user) }
    let(:workout_template) { build(:workout_template, user:, name: "Old name") }
    let(:attributes) do
      {
        name: "  Push day  ",
        notes: "  Bench + incline  ",
        active: "1"
      }
    end

    it "persists normalized attributes" do
      expect { result }.to change(WorkoutTemplate, :count).by(1)
      expect(result).to be_success
      expect(result.value!.name).to eq("Push day")
      expect(result.value!.notes).to eq("Bench + incline")
      expect(result.value!).to be_active
    end

    context "with invalid attributes" do
      let(:attributes) do
        {
          name: " ",
          notes: "  ",
          active: "0"
        }
      end

      it "returns a failure and leaves the record unsaved" do
        expect { result }.not_to change(WorkoutTemplate, :count)
        expect(result).to be_failure
        expect(result.failure[:workout_template].errors[:name]).to include("can't be blank")
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
