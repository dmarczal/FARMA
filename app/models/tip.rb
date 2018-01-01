class Tip < ActiveRecord::Base
  belongs_to :question

  validates :content, :number_of_tries, presence: true
  validates :number_of_tries, numericality: {greater_than: 0, only_integer: true}
  
  validates_uniqueness_of :number_of_tries, scope: :question_id
end
