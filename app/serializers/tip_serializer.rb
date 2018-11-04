class TipSerializer < ActiveModel::Serializer
  attributes :id, :content, :number_of_tries
end
