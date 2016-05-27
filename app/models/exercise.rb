class Exercise < ActiveRecord::Base
  belongs_to :lo, counter_cache: true
  has_many :questions, dependent: :destroy

  validates :lo_id, presence: true

  include AuthenticationAndPosition
  # before_create :default_position
  # validates :title, :content, presence: true
  # private
  #   def default_position
  #     self.position = Time.now
  #   end
end
