module Constants
  SUPPORTED_LOCALES = %w[en ru].freeze
  SUPPORTED_LOCALE_KEYS = SUPPORTED_LOCALES.map(&:to_sym).freeze
end
