class Introduction < ActiveRecord::Base
  belongs_to :lo , counter_cache: true

  validates :title, :content, presence: true

end
