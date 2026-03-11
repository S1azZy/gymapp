module SystemAuthHelpers
  def sign_in_as(user, password: "supersecure123")
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_button "Sign in"
  end

  def sign_out
    click_button "Sign out"
  end
end

RSpec.configure do |config|
  config.include SystemAuthHelpers, type: :system
end
