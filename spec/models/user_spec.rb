require "rails_helper"

describe User do
  describe ".reminders_required" do
    before :each do
      @item_to_remind = Fabricate(:item)
      @item_to_not_remind = Fabricate(:item)

      @item_to_remind.reminder_date = Time.now-2.days
      @item_to_remind.save

      User.all.each do |user|
        user.last_reminded = Time.now - 3.days
        user.save
      end
    end

    it "tells which users need reminders sent to them" do
      answer = User.reminders_required
      expect(answer).to eq([ @item_to_remind.user ])
    end
  end
end
