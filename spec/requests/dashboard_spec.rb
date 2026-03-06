require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /dashboard" do
    context "when unauthenticated" do
      before do
        get dashboard_path
      end

      it "redirects guests to the sign-in page" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated" do
      include_context "with authenticated user"

      before { get dashboard_path }

      it "returns success for authenticated users" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the authenticated email" do
        expect(response.body).to include(user.email)
      end
    end
  end
end
