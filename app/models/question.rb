class Question < ActiveRecord::Base
  belongs_to :exercise, counter_cache: true
  has_many :tips, dependent: :destroy

  validates :correct_answer, presence: true

  include AuthenticationAndPosition
  # before_create :default_position
  # validates :title, :content, presence: true
  # private
  #   def default_position
  #     self.position = Time.now
  #   end
end
