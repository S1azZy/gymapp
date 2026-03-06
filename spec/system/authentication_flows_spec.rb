require "rails_helper"

RSpec.describe "Authentication flows", type: :system do
  describe "sign up and sign out" do
    before do
      sign_up_as("new-member@example.com")
    end

    it "redirects to the dashboard after sign up" do
      expect(page).to have_current_path(dashboard_path, ignore_query: false)
    end

    it "shows the success flash" do
      expect(page).to have_text("Account created successfully.")
    end

    it "allows the user to sign out" do
      click_button "Sign out"

      expect(page).to have_current_path(root_path, ignore_query: false)
    end
  end

  describe "locale switching" do
    before do
      visit root_path
      click_link "RU"
    end

    it "switches the current page locale" do
      expect(page).to have_text("Трекер тренировок")
    end

    it "keeps the chosen locale on the next page" do
      click_link "Войти", match: :first

      expect(page).to have_text("Используйте аккаунт Gym App")
    end
  end

  describe "password reset" do
    let(:user) { create(:user, email: "member@example.com", password: "supersecure123") }

    before do
      request_password_reset_for(user.email)
      visit_password_reset_form
      update_password_to("evenmoresecure123")
    end

    it "redirects to sign in after resetting the password" do
      expect(page).to have_current_path(new_session_path, ignore_query: false)
    end

    it "updates the persisted password" do
      expect(user.reload.authenticate("evenmoresecure123")).to eq(user)
    end
  end

  def sign_up_as(email)
    visit root_path
    click_link "Sign up", match: :first
    fill_in "Email", with: email
    fill_in "Password", with: "supersecure123"
    fill_in "Confirm password", with: "supersecure123"
    click_button "Create account"
  end

  def request_password_reset_for(email)
    visit new_password_reset_path
    fill_in "Email", with: email
    click_button "Send reset instructions"
  end

  def visit_password_reset_form
    raw_token = ActionMailer::Base.deliveries.last.body.encoded[%r{token=([^"\s]+)}, 1]
    token = PasswordResetToken.order(:created_at).last

    visit edit_password_reset_path(token, token: raw_token)
  end

  def update_password_to(password)
    fill_in "New password", with: password
    fill_in "Confirm new password", with: password
    click_button "Update password"
  end
end
