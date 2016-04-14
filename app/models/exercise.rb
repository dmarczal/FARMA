class Exercise < ActiveRecord::Base
  belongs_to :lo, counter_cache: true
  has_many :questions, dependent: :destroy

  before_create :default_position

  validates :title, :content, :lo_id, presence: true

  private
  def default_position
    self.position = Time.now
  end
end
