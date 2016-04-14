class Introduction < ActiveRecord::Base
  belongs_to :lo , counter_cache: true

  before_create :default_position

  validates :title, :content, :lo, presence: true

  private
  def default_position
    self.position = Time.now
  end
end
