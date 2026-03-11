# rubocop:disable RSpec/MultipleExpectations
require "rails_helper"

RSpec.describe "WorkoutTemplates", type: :request do
  describe "GET /workout_templates" do
    context "when unauthenticated" do
      before { get workout_templates_path }

      it "redirects to sign in" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated" do
      include_context "with authenticated user"

      let(:owned_template) { create(:workout_template, user:, name: "My plan") }
      let(:other_template) { create(:workout_template, name: "Other plan") }

      before do
        owned_template
        other_template
        get workout_templates_path
      end

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "shows only owner templates" do
        expect(response.body).to include("My plan")
        expect(response.body).not_to include("Other plan")
      end
    end
  end

  describe "GET /workout_templates/:id" do
    context "when authenticated as owner" do
      include_context "with authenticated user"

      let(:workout_template) { create(:workout_template, user:, name: "Upper / Lower") }

      before { get workout_template_path(workout_template) }

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the template name" do
        expect(response.body).to include("Upper / Lower")
      end
    end

    context "when accessing another user template" do
      include_context "with authenticated user"

      let(:workout_template) { create(:workout_template) }

      before { get workout_template_path(workout_template) }

      it "redirects to root" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /workout_templates" do
    subject(:perform_request) { post workout_templates_path, params: template_params }

    include_context "with authenticated user"

    let(:template_params) do
      {
        workout_template: {
          name: "Push",
          notes: "Chest and triceps",
          active: "1"
        }
      }
    end

    it "creates a workout template for the current user" do
      expect { perform_request }.to change(user.workout_templates, :count).by(1)
    end

    it "redirects to the template page" do
      perform_request

      expect(response).to redirect_to(workout_template_path(WorkoutTemplate.order(:created_at).last))
    end

    context "with invalid attributes" do
      let(:template_params) do
        {
          workout_template: {
            name: " ",
            notes: "Invalid"
          }
        }
      end

      it "does not create a workout template" do
        expect { perform_request }.not_to change(WorkoutTemplate, :count)
      end

      it "renders unprocessable content" do
        perform_request
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /workout_templates/:id" do
    subject(:perform_request) { patch workout_template_path(workout_template), params: template_params }

    include_context "with authenticated user"

    let(:workout_template) { create(:workout_template, user:, name: "Push") }
    let(:template_params) do
      {
        workout_template: {
          name: "Push A",
          notes: "Heavy chest",
          active: "0"
        }
      }
    end

    it "updates the workout template" do
      perform_request
      workout_template.reload

      expect(workout_template.name).to eq("Push A")
      expect(workout_template.notes).to eq("Heavy chest")
      expect(workout_template).not_to be_active
    end

    context "when updating another user template" do
      let(:workout_template) { create(:workout_template) }

      it "does not update the workout template" do
        perform_request
        expect(workout_template.reload.name).not_to eq("Push A")
      end

      it "redirects to root" do
        perform_request
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE /workout_templates/:id" do
    subject(:perform_request) { delete workout_template_path(workout_template) }

    include_context "with authenticated user"

    let(:workout_template) { create(:workout_template, user:) }

    before { workout_template }

    it "destroys the owned workout template" do
      expect { perform_request }.to change(WorkoutTemplate, :count).by(-1)
    end

    context "when deleting another user template" do
      let(:workout_template) { create(:workout_template) }

      before { workout_template }

      it "does not destroy the workout template" do
        expect { perform_request }.not_to change(WorkoutTemplate, :count)
      end

      it "redirects to root" do
        perform_request
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
