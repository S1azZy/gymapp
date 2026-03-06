module Auth
  module Passwords
    class Reset < ApplicationInteractor
      option :password_reset_token
      option :password
      option :password_confirmation

      class ValidationContract < ApplicationContract
        params do
          required(:password_reset_token)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
        end
      end

      def call
        user = password_reset_token.user

        user.password = password
        user.password_confirmation = password_confirmation

        return Failure(code: :invalid_attributes, errors: user.errors.to_hash) unless user.valid?

        in_transaction do
          user.save!
          user.user_sessions.delete_all
          user.password_reset_tokens.update_all(used_at: Time.current, updated_at: Time.current)
        end

        Success(user)
      end
    end
  end
end
