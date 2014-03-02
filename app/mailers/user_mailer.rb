class UserMailer < ActionMailer::Base
  default from: "reminder@reminder-agent.com"

  def reminder_email (user)
    @user = user
    mail(to: @user.email, subject: "You have items to review.")
  end
end
