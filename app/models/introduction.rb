class Introduction < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :lo , counter_cache: true
  has_many :progress_introductions
  has_and_belongs_to_many :tags

  validates :lo, presence: true
end
