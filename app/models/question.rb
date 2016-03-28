class Question < ActiveRecord::Base
  belongs_to :exercise, counter_cache: true

  before_create {self.position = Time.now}
  validates :title, :content, :correct_answer, presence: true

end
