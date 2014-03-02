class Reminder
  def run
    users = User.reminders_required
    users.each do |user|
      UserMailer.reminder_email(user).deliver
    end
  end
end
