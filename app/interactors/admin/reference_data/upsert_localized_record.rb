module Admin
  module ReferenceData
    class UpsertLocalizedRecord < ApplicationInteractor
      option :record
      option :active
      option :translations

      class ValidationContract < ApplicationContract
        params do
          required(:record)
          required(:active).filled(:bool)
          required(:translations).filled(:hash)
        end
      end

      def call
        record.active = active
        assign_translations

        return Failure(code: :invalid_attributes, record: invalid_record) unless valid_record?

        in_transaction do
          record.save!
          translations_to_persist.each(&:save!)
        end

        Success(record)
      end

      private

      def assign_translations
        existing_translations = record.public_send(translation_association_name).to_a

        @translations_to_persist = Constants::SUPPORTED_LOCALE_KEYS.map do |locale|
          locale_value = locale.to_s
          translation = existing_translations.find { |item| item.locale == locale_value }
          translation ||= record.public_send(translation_association_name).build(locale: locale_value)
          translation.name = translations.dig(locale_value, "name") || translations.dig(locale.to_sym, :name)
          translation
        end
      end

      def translation_association_name
        record.class.reflect_on_all_associations(:has_many)
          .find { |association| association.name.to_s.end_with?("_translations") }
          .name
      end

      def translations_to_persist
        @translations_to_persist || record.public_send(translation_association_name).to_a
      end

      def valid_record?
        record.valid?
        translations_to_persist.all?(&:valid?)
      end

      def invalid_record
        translations_to_persist.each do |translation|
          translation.errors.each do |error|
            record.errors.add(error.attribute, error.message)
          end
        end

        record
      end
    end
  end
end
