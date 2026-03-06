class PasswordResetMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @password_reset_token = params[:password_reset_token]
    @raw_token = params[:raw_token]

    mail(
      to: @user.email,
      subject: I18n.t("mailers.password_reset_mailer.reset_password.subject")
    )
  end
end
