module Auth
  module Users
    class Create < ApplicationInteractor
      option :email
      option :password
      option :password_confirmation
      option :preferred_locale, optional: true

      class ValidationContract < ApplicationContract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
          optional(:preferred_locale).filled(:string)
        end
      end

      def call
        user = User.new(
          email:,
          password:,
          password_confirmation:,
          preferred_locale: preferred_locale || I18n.default_locale.to_s
        )

        return Failure(code: :invalid_attributes, errors: validation_errors(user)) unless user.save

        Success(user)
      end

      private

      def validation_errors(user)
        user.errors.to_hash
      end
    end
  end
end
