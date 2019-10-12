class QuestionSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :correct_answer,
             :answer_tex,
             :precision,
             :variables
end
