module Auth
  module Passwords
    class RequestReset < ApplicationInteractor
      option :email

      class ValidationContract < ApplicationContract
        params do
          required(:email).filled(:string)
        end
      end

      def call
        user = User.find_by(email: normalized_email)
        return Success(nil) if user.blank?

        password_reset_token = nil
        raw_token = nil

        in_transaction do
          user.password_reset_tokens.delete_all
          raw_token = SecureRandom.urlsafe_base64(32)
          password_reset_token = user.password_reset_tokens.create!(
            token_digest: PasswordResetToken.digest(raw_token),
            expires_at: PasswordResetToken::RESET_WINDOW.from_now
          )
        end

        PasswordResetMailer
          .with(user:, password_reset_token:, raw_token:)
          .reset_password
          .deliver_now

        Success(password_reset_token)
      end

      private

      def normalized_email
        email.strip.downcase
      end
    end
  end
end
