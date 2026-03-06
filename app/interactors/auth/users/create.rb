module Auth
  module Users
    class Create < ApplicationInteractor
      option :email
      option :password
      option :password_confirmation

      class ValidationContract < ApplicationContract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
        end
      end

      def call
        user = User.new(
          email:,
          password:,
          password_confirmation:
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
