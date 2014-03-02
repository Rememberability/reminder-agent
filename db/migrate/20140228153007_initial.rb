class Initial < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.string :question
      t.text :answer
      t.string :aasm_state
      t.date :reminder_date
      t.belongs_to :user

      t.timestamps
    end

    create_table :users do |t|
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
