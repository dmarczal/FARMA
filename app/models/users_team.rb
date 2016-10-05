class UsersTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  validates_uniqueness_of :user_id, scope: :team_id
end
