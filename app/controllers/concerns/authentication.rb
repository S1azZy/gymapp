module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :resume_session
    helper_method :authenticated?, :current_user
  end

  private

  def authenticated?
    current_user.present?
  end

  def current_user
    Current.user
  end

  def require_authentication
    return if authenticated?

    redirect_to new_session_path, alert: t("auth.flash.please_sign_in")
  end

  def start_new_session_for(user)
    Current.user_session = user.user_sessions.create!(
      ip_address: request.remote_ip,
      user_agent: request.user_agent
    )
    Current.user = user

    cookies.signed.permanent[:user_session_id] = {
      value: Current.user_session.id,
      httponly: true,
      same_site: :lax,
      secure: Rails.env.production?
    }
  end

  def terminate_session
    Current.user_session&.destroy!
    cookies.delete(:user_session_id)
    Current.user_session = nil
    Current.user = nil
  end

  def resume_session
    session_id = cookies.signed[:user_session_id]
    return if session_id.blank?

    Current.user_session = UserSession.includes(:user).find_by(id: session_id)
    Current.user = Current.user_session&.user
  end
end
