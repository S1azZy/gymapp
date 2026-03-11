module Admin
  module ReferenceData
    class DestroyLocalizedRecord < ApplicationInteractor
      option :record

      class ValidationContract < ApplicationContract
        params do
          required(:record)
        end
      end

      def call
        record.destroy!
        Success(record)
      rescue ActiveRecord::DeleteRestrictionError, ActiveRecord::InvalidForeignKey
        Failure(code: :destroy_failed, record:)
      end
    end
  end
end
