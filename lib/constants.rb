module Constants
  SUPPORTED_LOCALES = %w[en ru].freeze
  SUPPORTED_LOCALE_KEYS = SUPPORTED_LOCALES.map(&:to_sym).freeze
  CATALOG_KEY_FORMAT = /\A[a-z0-9_]+\z/
  DEFAULT_REFERENCE_POSITION = 100

  def self.normalize_catalog_key(value)
    value
      .to_s
      .strip
      .downcase
      .tr(" -", "__")
      .gsub(/_+/, "_")
      .gsub(/\A_+|_+\z/, "")
  end
end
