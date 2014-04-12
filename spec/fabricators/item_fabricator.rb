Fabricator :item do
  question { sequence(:question) {|i| "Question #{i}"} }
  answer { sequence(:answer) {|i| "Answer #{i}"} }
  reminder_date Time.now
  user
end
