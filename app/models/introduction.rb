class Introduction < ActiveRecord::Base
  belongs_to :lo , counter_cache: true

  before_create {self.position = self.created_at}
  validates :title, :content, :lo_id, presence: true

end
