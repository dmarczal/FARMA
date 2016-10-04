class Team < ActiveRecord::Base
  has_many :users_teams
  has_many :los_teams
  has_many :los , through: :los_teams
  has_many :users, through: :users_teams
  belongs_to :user

end
