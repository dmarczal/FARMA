class Exercise < ActiveRecord::Base
  belongs_to :lo , counter_cache: true

  has_many :question

  before_create {self.position = Time.now}

  validates :title, :content, :lo_id, presence: true
end
