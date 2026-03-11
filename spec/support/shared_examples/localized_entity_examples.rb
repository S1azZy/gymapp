RSpec.shared_examples "localized entity" do |factory_name, translation_factory_name, expected_name|
  describe "#translation_for" do
    subject(:translation_for_locale) { record.translation_for(requested_locale) }

    let(:record) { create(factory_name) }
    let(:requested_locale) { :ru }

    before do
      create(translation_factory_name, factory_name => record, locale: "en", name: "English")
      create(translation_factory_name, factory_name => record, locale: "ru", name: expected_name)
    end

    it "returns translation for provided locale" do
      expect(translation_for_locale&.name).to eq(expected_name)
    end
  end

  describe "#localized_name" do
    subject(:localized_name) { record.localized_name(:en) }

    let(:record) { create(factory_name) }

    before do
      create(translation_factory_name, factory_name => record, locale: "en", name: expected_name)
    end

    it "returns localized name" do
      expect(localized_name).to eq(expected_name)
    end
  end
end
