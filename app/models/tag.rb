class Tag < ActiveRecord::Base
  has_and_belongs_to_many :los
  has_and_belongs_to_many :exercises
  has_and_belongs_to_many :introductions
end
