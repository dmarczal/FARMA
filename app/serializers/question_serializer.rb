class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :position, :content, :correct_answer, :precision, :exercise_id

  has_many :tips
end
