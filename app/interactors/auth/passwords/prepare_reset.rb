module Auth
  module Passwords
    class PrepareReset < ApplicationInteractor
      option :id
      option :token

      class ValidationContract < ApplicationContract
        params do
          required(:id).filled(:string)
          required(:token).filled(:string)
        end
      end

      def call
        password_reset_token = PasswordResetToken.includes(:user).find_by(id:)
        return Failure(code: :invalid_token) if password_reset_token.blank?
        return Failure(code: :invalid_token) unless secure_match?(password_reset_token)
        return Failure(code: :invalid_token) unless password_reset_token.active?

        Success(password_reset_token)
      end

      private

      def secure_match?(password_reset_token)
        ActiveSupport::SecurityUtils.secure_compare(
          password_reset_token.token_digest,
          PasswordResetToken.digest(token)
        )
      end
    end
  end
end
