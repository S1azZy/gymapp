require "rails_helper"

RSpec.describe "Locales", type: :request do
  describe "locale selection" do
    subject(:perform_request) { get root_path(locale:) }

    let(:locale) { :ru }

    it "renders the requested locale" do
      perform_request

      expect(response.body).to include("Трекер тренировок")
    end

    it "persists the locale in a signed cookie for guests" do
      perform_request
      get root_path

      expect(response.body).to include("Трекер тренировок")
    end

    it "falls back to the default locale for unsupported locales" do
      get root_path(locale: :de)

      expect(response.body).to include("Track gym workouts")
    end

    it "uses Accept-Language for guests without an explicit preference" do
      get root_path, headers: { "HTTP_ACCEPT_LANGUAGE" => "ru-RU,ru;q=0.9,en;q=0.8" }

      expect(response.body).to include("Трекер тренировок")
    end
  end

  describe "locale selection for authenticated users" do
    let(:user) { create(:user, preferred_locale: "en") }

    before do
      post session_path, params: {
        session: {
          email: user.email,
          password: "supersecure123"
        }
      }
    end

    it "persists the chosen locale in the user profile" do
      get root_path(locale: :ru)

      expect(user.reload.preferred_locale).to eq("ru")
    end

    it "uses the persisted user locale on subsequent requests" do
      user.update!(preferred_locale: "ru")
      get root_path

      expect(response.body).to include("Трекер тренировок")
    end
  end
end
