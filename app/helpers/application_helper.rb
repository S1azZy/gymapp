module ApplicationHelper
  LOCALE_LABELS = {
    en: "EN",
    ru: "RU"
  }.freeze

  def auth_form_with(url:, scope:, method: nil, **options, &block)
    form_with(
      url:,
      scope:,
      method:,
      class: "auth-form",
      **options,
      &block
    )
  end

  def secondary_link_to(label, url, **options)
    link_to(label, url, class: "secondary-link", **options)
  end

  def app_nav_link_to(label, url, **options)
    link_to(label, url, class: "app-nav__link", **options)
  end

  def app_nav_button_to(label, url, **options)
    button_to(label, url, class: "app-nav__button", **options)
  end

  def locale_label(locale)
    LOCALE_LABELS.fetch(locale.to_sym)
  end

  def locale_switch_link(locale)
    css_class = [ "locale-switcher__link" ]
    css_class << "locale-switcher__link--active" if current_locale == locale.to_sym

    link_to locale_label(locale), locale_switch_path(locale), class: css_class.join(" ")
  end
end
