require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    subject(:perform_request) { get root_path }

    before do
      perform_request
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:ok)
    end

    it "renders the application name" do
      expect(response.body).to include("Gym App")
    end
  end

  describe "GET / for an authenticated user" do
    subject(:perform_request) { get root_path }

    let(:user) { create(:user) }

    before do
      post session_path, params: { session: { email: user.email, password: "supersecure123" } }
      perform_request
    end

    it "renders the signed-in state" do
      expect(response.body).to include(user.email)
    end
  end
end
