require "rails_helper"

RSpec.describe "Locales", type: :request do
  describe "locale selection" do
    subject(:perform_request) { get root_path(locale:) }

    let(:locale) { :ru }

    it "renders the requested locale" do
      perform_request
      expect(response.body).to include("Трекер тренировок")
    end

    it "persists the locale in the session" do
      perform_request
      get root_path

      expect(response.body).to include("Трекер тренировок")
    end

    it "falls back to the default locale for unsupported locales" do
      get root_path(locale: :de)

      expect(response.body).to include("Track gym workouts")
    end
  end
end
