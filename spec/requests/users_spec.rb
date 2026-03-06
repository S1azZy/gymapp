require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    before do
      get new_user_path
    end

    it "renders the sign-up page" do
      expect(response).to have_http_status(:ok)
    end

    it "shows the sign-up heading" do
      expect(response.body).to include("Create account")
    end
  end

  describe "POST /users" do
    subject(:perform_request) { post users_path, params: user_params }

    let(:user_params) do
      {
        user: {
          email: "new-user@example.com",
          password: "supersecure123",
          password_confirmation: "supersecure123"
        }
      }
    end

    it "creates a user for valid attributes" do
      expect { perform_request }.to change(User, :count).by(1)
    end

    it "creates a user session for valid attributes" do
      expect { perform_request }.to change(UserSession, :count).by(1)
    end

    it "redirects valid sign-up to the dashboard" do
      perform_request

      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "POST /users with invalid attributes" do
    subject(:perform_request) { post users_path, params: user_params }

    let(:user_params) do
      {
        user: {
          email: "new-user@example.com",
          password: "supersecure123",
          password_confirmation: "mismatch"
        }
      }
    end

    it "does not create a user" do
      expect { perform_request }.not_to change(User, :count)
    end

    it "does not create a user session" do
      expect { perform_request }.not_to change(UserSession, :count)
    end

    it "returns an unprocessable entity response" do
      perform_request

      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
