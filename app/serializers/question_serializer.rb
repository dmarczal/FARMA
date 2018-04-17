class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :position, :content, :correct_answer

  has_many :tips
end
