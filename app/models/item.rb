class Item < ActiveRecord::Base
  include AASM
  belongs_to :user

  REMINDER_INTERVAL_IN_DAYS = {
    one: 1,
    seven: 7,
    sixteen: 16,
    thirty_five: 35
  }

  before_create :set_reminder

  aasm do
    state :one, initial: true
    state :seven
    state :sixteen
    state :thirty_five

    event :remember, after: :set_reminder do
      transitions from: :one, to: :seven, after_event: :set_reminder
      transitions from: :seven, to: :sixteen
      transitions from: :sixteen, to: :thirty_five
      transitions from: :thirty_five, to: :thirty_five
    end

    event :forget, after: :set_reminder do
      transitions from: :one, to: :one
      transitions from: :seven, to: :one
      transitions from: :sixteen, to: :one
      transitions from: :thirty_five, to: :one
    end
  end

  private
  def set_reminder
    self.reminder_date = Time.now +
      self.class::REMINDER_INTERVAL_IN_DAYS[self.aasm.current_state].days
  end
end
