RSpec.shared_examples "translation model" do |owner_association, locales: %w[en ru]|
  subject(:translation) { build(described_class.model_name.singular.to_sym) }

  before do
    create(described_class.model_name.singular.to_sym)
  end

  it { is_expected.to belong_to(owner_association) }
  it { is_expected.to validate_presence_of(owner_association) }
  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_inclusion_of(:locale).in_array(locales) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }

  it "normalizes name before validation" do
    translation.name = "  Name value  "
    translation.valid?

    expect(translation.name).to eq("Name value")
  end
end
