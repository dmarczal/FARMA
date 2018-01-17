class Exercise < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :lo, counter_cache: true
  has_many :questions, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :lo, presence: true

  delegate :user, to: :lo
end
