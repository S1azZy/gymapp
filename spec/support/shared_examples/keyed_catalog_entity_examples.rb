RSpec.shared_examples "keyed catalog entity" do |factory_name, positioned: true|
  subject(:record) { build(factory_name) }

  before do
    create(factory_name)
  end

  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_uniqueness_of(:key).case_insensitive }
  it { is_expected.to allow_value("valid_key_123").for(:key) }
  it { is_expected.not_to allow_value("invalid.key").for(:key) }

  if positioned
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_numericality_of(:position).only_integer.is_greater_than_or_equal_to(0) }
  end

  it "normalizes key before validation" do
    record.key = "  Bench- Press  "
    record.valid?

    expect(record.key).to eq("bench_press")
  end

  it "keeps key immutable after creation" do
    persisted_record = create(factory_name)

    persisted_record.key = "new_key"
    persisted_record.valid?

    expect(persisted_record.errors[:key]).to include("cannot be changed")
  end
end
