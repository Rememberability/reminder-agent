class ItemSerializer < ActiveModel::Serializer
  attributes :question, :answer, :reminder_date, :id
end
