class PasswordResetsController < ApplicationController
  auth_rate_limit name: :create_password_reset,
    to: 5,
    within: 10.minutes,
    only: :create,
    redirect_to: :new_password_reset_path

  before_action :load_reset_context, only: %i[edit update]

  def new; end

  def create
    Auth::Passwords::RequestReset.call(email: password_reset_email)

    redirect_to new_session_path, notice: t("auth.flash.password_reset_requested")
  end

  def edit; end

  def update
    result = Auth::Passwords::Reset.call(
      password_reset_token: @password_reset_token,
      password: password_reset_params[:password],
      password_confirmation: password_reset_params[:password_confirmation]
    )

    if result.success?
      redirect_to new_session_path, notice: t("auth.flash.password_reset_completed")
    else
      flash.now[:alert] = t("auth.flash.password_reset_failed")
      render :edit, status: :unprocessable_content
    end
  end

  private

  def load_reset_context
    result = Auth::Passwords::PrepareReset.call(
      id: params[:id],
      token: params[:token]
    )

    if result.success?
      @password_reset_token = result.value!
    else
      redirect_to new_password_reset_path, alert: t("auth.flash.password_reset_invalid")
    end
  end

  def password_reset_email
    params.expect(password_reset: [ :email ])[:email]
  end

  def password_reset_params
    params.expect(password_reset: %i[password password_confirmation])
  end
end
