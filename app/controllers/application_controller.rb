class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Authentication
  include AuthRateLimitable
  include Pundit::Authorization

  around_action :switch_locale

  helper_method :available_locales, :current_locale, :locale_switch_path

  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

  private

  def switch_locale(&block)
    locale = resolved_locale
    persist_locale_preference(locale) if params[:locale].present?

    I18n.with_locale(locale, &block)
  end

  def current_locale
    I18n.locale
  end

  def available_locales
    Constants::SUPPORTED_LOCALE_KEYS
  end

  def default_url_options
    return {} if current_locale == I18n.default_locale

    { locale: current_locale }
  end

  def locale_switch_path(locale)
    url_for(
      request.path_parameters.merge(
        request.query_parameters.except("locale").merge(locale:)
      )
    )
  end

  def resolved_locale
    normalize_locale(params[:locale]) ||
      normalize_locale(current_user&.preferred_locale) ||
      normalize_locale(cookies.signed[:locale]) ||
      request_accepted_locale ||
      I18n.default_locale
  end

  def normalize_locale(locale)
    return if locale.blank?

    normalized_locale = locale.to_s.tr("-", "_").downcase.to_sym
    normalized_locale if Constants::SUPPORTED_LOCALE_KEYS.include?(normalized_locale)
  end

  def request_accepted_locale
    accepted_languages.each do |language|
      normalized_locale = normalize_locale(language)
      return normalized_locale if normalized_locale

      primary_subtag = language.to_s.split(/[-_]/).first
      normalized_locale = normalize_locale(primary_subtag)
      return normalized_locale if normalized_locale
    end

    nil
  end

  def accepted_languages
    request
      .get_header("HTTP_ACCEPT_LANGUAGE")
      .to_s
      .split(",")
      .map { |entry| entry.split(";").first.to_s.strip }
      .reject(&:blank?)
  end

  def persist_locale_preference(locale)
    if authenticated?
      current_user.update!(preferred_locale: locale.to_s) if current_user.preferred_locale != locale.to_s
      cookies.delete(:locale)
    else
      cookies.signed.permanent[:locale] = {
        value: locale.to_s,
        httponly: true,
        same_site: :lax,
        secure: Rails.env.production?
      }
    end
  end

  def handle_not_authorized
    redirect_to root_path, alert: t("authorization.not_allowed")
  end

  def handle_auth_rate_limit(path)
    redirect_to path, alert: t("auth.flash.rate_limited")
  end
end
