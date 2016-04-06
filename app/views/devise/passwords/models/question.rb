class Question < ActiveRecord::Base
  belongs_to :exercise, counter_cache: true

  before_create :default_position

  validates :title, :content, :correct_answer, presence: true

  private
  def default_position
    self.position = Time.now
  end
end
