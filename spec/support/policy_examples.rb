RSpec.shared_examples "denies anonymous access" do |policy_method|
  it "denies access" do
    expect(described_class.new(nil, record).public_send(policy_method)).to be(false)
  end
end
