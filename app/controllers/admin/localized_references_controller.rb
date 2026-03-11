module Admin
  class LocalizedReferencesController < BaseController
    before_action :set_record, only: %i[edit update destroy]

    helper_method :collection_path, :new_record_path, :resource_label, :resource_labels, :translations_for_form

    def index
      @records = model_class.includes(translation_association).order(position: :asc, created_at: :asc)

      render "admin/localized_references/index"
    end

    def new
      @record = model_class.new(
        active: true,
        position: Constants::DEFAULT_REFERENCE_POSITION
      )
      ensure_translations(@record)

      render "admin/localized_references/new"
    end

    def edit
      ensure_translations(@record)

      render "admin/localized_references/edit"
    end

    def create
      @record = model_class.new
      result = Admin::ReferenceData::UpsertLocalizedRecord.call(
        record: @record,
        key: key_value,
        position: position_value,
        active: active_value,
        translations: translations_value
      )

      if result.success?
        redirect_to collection_path, notice: t("admin.reference_data.flash.created", resource: resource_label)
      else
        render_invalid_record(result.failure[:record])
      end
    end

    def update
      result = Admin::ReferenceData::UpsertLocalizedRecord.call(
        record: @record,
        key: key_value,
        position: position_value,
        active: active_value,
        translations: translations_value
      )

      if result.success?
        redirect_to collection_path, notice: t("admin.reference_data.flash.updated", resource: resource_label)
      else
        render_invalid_record(result.failure[:record])
      end
    end

    def destroy
      result = Admin::ReferenceData::DestroyLocalizedRecord.call(record: @record)

      if result.success?
        redirect_to collection_path, notice: t("admin.reference_data.flash.destroyed", resource: resource_label)
      else
        redirect_to collection_path, alert: t("admin.reference_data.flash.destroy_failed", resource: resource_label)
      end
    end

    private

    def set_record
      @record = model_class.includes(translation_association).find(params[:id])
    end

    def ensure_translations(record)
      Constants::SUPPORTED_LOCALE_KEYS.each do |locale|
        record.public_send(translation_association).find_or_initialize_by(locale: locale.to_s)
      end
    end

    def render_invalid_record(record)
      @record = record
      ensure_translations(@record)
      render action_name == "create" ? "admin/localized_references/new" : "admin/localized_references/edit", status: :unprocessable_entity
    end

    def collection_path
      public_send("admin_#{model_class.model_name.route_key}_path")
    end

    def new_record_path
      public_send("new_admin_#{model_class.model_name.singular_route_key}_path")
    end

    def resource_key
      model_class.model_name.route_key
    end

    def resource_label
      t("admin.reference_data.resources.#{resource_key}.singular")
    end

    def resource_labels
      t("admin.reference_data.resources.#{resource_key}")
    end

    def translations_for_form
      @record.public_send(translation_association).index_by(&:locale)
    end

    def active_value
      ActiveModel::Type::Boolean.new.cast(reference_params[:active])
    end

    def key_value
      value = reference_params[:key].to_s
      value.presence || @record&.key.to_s
    end

    def position_value
      reference_params[:position].to_i
    end

    def translations_value
      reference_params.fetch(:translations, {}).to_h
    end

    def reference_params
      params.fetch(model_class.model_name.param_key, {}).permit(
        :key,
        :position,
        :active,
        translations: Constants::SUPPORTED_LOCALE_KEYS.index_with { [ :name ] }
      )
    end
  end
end
