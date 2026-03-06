module Auth
  module Sessions
    class Create < ApplicationInteractor
      option :email
      option :password

      class ValidationContract < ApplicationContract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end
      end

      def call
        user = User.find_by(email: normalized_email)
        return Failure(code: :invalid_credentials) unless user&.authenticate(password)

        Success(user)
      end

      private

      def normalized_email
        email.strip.downcase
      end
    end
  end
end
