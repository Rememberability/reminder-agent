class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  has_many :items, dependent: :destroy

  before_create :set_initial_values

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
