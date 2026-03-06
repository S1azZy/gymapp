class SessionsController < ApplicationController
  auth_rate_limit name: :create_session,
    to: 5,
    within: 3.minutes,
    only: :create,
    redirect_to: :new_session_path

  def new; end

  def create
    result = Auth::Sessions::Create.call(
      email: session_params[:email],
      password: session_params[:password]
    )

    if result.success?
      start_new_session_for(result.value!)
      redirect_to dashboard_path, notice: t("auth.flash.signed_in")
    else
      flash.now[:alert] = t("auth.flash.invalid_credentials")
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: t("auth.flash.signed_out")
  end

  private

  def session_params
    params.expect(session: %i[email password])
  end
end
