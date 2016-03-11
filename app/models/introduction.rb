class Introduction < ActiveRecord::Base
  belongs_to :lo , counter_cache: true,
                   dependent: :destroy
  validates :title, :content, :lo_id, presence: true

end
