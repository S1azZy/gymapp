require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  before do
    create(:user)
  end

  it { is_expected.to have_many(:workout_templates).dependent(:destroy) }
  it { is_expected.to have_many(:user_sessions).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:preferred_locale) }
  it { is_expected.to validate_inclusion_of(:preferred_locale).in_array(%w[en ru]) }

  it do
    expect(user)
      .to define_enum_for(:role)
      .backed_by_column_of_type(:string)
      .with_values(member: "member", admin: "admin")
  end

  it "normalizes email before validation" do
    user.email = "  USER@Example.COM "
    user.valid?

    expect(user.email).to eq("user@example.com")
  end
end
