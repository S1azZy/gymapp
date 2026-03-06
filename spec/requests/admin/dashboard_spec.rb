require "rails_helper"

RSpec.describe "Admin::Dashboard", type: :request do
  describe "GET /admin" do
    context "when unauthenticated" do
      before { get admin_dashboard_path }

      it "redirects to sign in" do
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when authenticated as a member" do
      include_context "with authenticated user"

      before { get admin_dashboard_path }

      it "redirects to the home page" do
        expect(response).to redirect_to(root_path)
      end

      it "shows an authorization alert" do
        expect(flash[:alert]).to eq(I18n.t("authorization.not_allowed"))
      end
    end

    context "when authenticated as an admin" do
      let(:user) { create(:user, :admin) }

      before do
        post session_path, params: {
          session: {
            email: user.email,
            password: "supersecure123"
          }
        }
        get admin_dashboard_path
      end

      it "returns success" do
        expect(response).to have_http_status(:ok)
      end

      it "renders the admin page" do
        expect(response.body).to include(I18n.t("admin.dashboard.title"))
      end
    end
  end
end
