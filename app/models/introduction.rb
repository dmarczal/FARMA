class Introduction < ActiveRecord::Base
  belongs_to :lo , counter_cache: true,
                   dependent: :destroy

  after_save :auto_position

  validates :title, :content, :lo, presence: true

  def auto_position
    lo = Lo.find(self.lo_id)
    self.position = lo.introductions_count + lo.exercises_count
  end
end
