class UsersController < ApplicationController
  auth_rate_limit name: :create_user,
    to: 3,
    within: 10.minutes,
    only: :create,
    redirect_to: :new_user_path

  def new
    @user = User.new
  end

  def create
    result = Auth::Users::Create.call(
      user_params.to_h.symbolize_keys.merge(preferred_locale: resolved_locale.to_s)
    )

    if result.success?
      start_new_session_for(result.value!)
      redirect_to dashboard_path, notice: t("auth.flash.signed_up")
    else
      @user = User.new(user_params.except(:password, :password_confirmation))
      flash.now[:alert] = t("auth.flash.sign_up_failed")
      render :new, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.expect(user: %i[email password password_confirmation])
  end
end
