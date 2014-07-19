class User < ActiveRecord::Base
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  has_many :items, dependent: :destroy
  before_create :set_initial_values

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  scope :reminders_required, -> do
    joins(:items).where(
      "reminder_date < :now AND last_reminded < :one_day_ago",
      {
        now: Time.now,
        one_day_ago: Time.now - 1.day
      }
    ).distinct
  end

  private
  def set_initial_values
    self.last_reminded = Time.now
  end
end
