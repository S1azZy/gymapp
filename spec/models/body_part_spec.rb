require "rails_helper"

RSpec.describe BodyPart, type: :model do
  it { is_expected.to have_many(:body_part_translations).dependent(:destroy) }
  it { is_expected.to have_many(:exercises).dependent(:restrict_with_exception) }

  it_behaves_like "keyed catalog entity", :body_part
  it_behaves_like "localized entity", :body_part, :body_part_translation, "Грудь"
end
