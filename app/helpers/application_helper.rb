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

  def admin_reference_action_label(action, resource = nil)
    key = "admin.reference_data.actions.#{action}"
    resource ? t(key, resource:) : t(key)
  end

  def admin_reference_delete_confirmation(resource)
    t("admin.reference_data.confirm_delete", resource:)
  end

  def admin_reference_edit_title(resource)
    admin_reference_action_label(:edit_resource, resource)
  end

  def admin_reference_empty_text(resource)
    t("admin.reference_data.empty", resource:)
  end

  def admin_reference_form_subtitle(resource)
    t("admin.reference_data.form_subtitle", resource:)
  end

  def admin_reference_index_subtitle(resource)
    t("admin.reference_data.index_subtitle", resource:)
  end

  def admin_reference_missing_translation
    t("admin.reference_data.missing_translation")
  end

  def admin_reference_locale_heading(locale)
    t(
      "admin.reference_data.fields.locale_heading",
      locale_name: locale_label(locale)
    )
  end

  def admin_reference_resource_label(resource, form)
    t("admin.reference_data.resources.#{resource}.#{form}")
  end

  def admin_reference_status_label(status_key)
    t("admin.reference_data.statuses.#{status_key}")
  end

  def admin_dashboard_resource_path(resource_key)
    public_send("admin_#{resource_key}_path")
  end

  def admin_dashboard_new_resource_path(resource_key)
    public_send("new_admin_#{resource_key.to_s.singularize}_path")
  end

  def admin_dashboard_resource_count_text(count)
    t("admin.dashboard.resource_count", count:)
  end

  def localized_option_name(record)
    record.localized_name || record.localized_name(:en) || record.key
  end

  def localized_exercise_name(exercise)
    exercise.localized_name || exercise.localized_name(:en) || exercise.key
  end

  def catalog_select_options(records, selected)
    options_for_select(records.map { |record| [ localized_option_name(record), record.id ] }, selected)
  end

  def catalog_exercise_classification_text(exercise)
    t(
      "catalog.exercises.meta.classification",
      body_part: localized_option_name(exercise.body_part),
      muscle_group: localized_option_name(exercise.muscle_group),
      equipment_type: localized_option_name(exercise.equipment_type)
    )
  end

  def catalog_exercise_synonyms(exercise)
    exercise.localized_synonyms.presence || exercise.localized_synonyms(:en)
  end

  def catalog_exercise_description(exercise)
    exercise.localized_description || exercise.localized_description(:en)
  end

  def catalog_filter_search_field(form, value:, placeholder:)
    form.search_field(:query, value:, placeholder:)
  end

  def catalog_filter_select_field(form, field, options, blank_label)
    form.select(field, options, include_blank: blank_label)
  end
end
