class Team < ActiveRecord::Base
  has_many :users_teams, dependent: :destroy
  has_many :los_teams, dependent: :destroy
  has_many :los , through: :los_teams
  has_many :users, through: :users_teams
  has_many :tips_counts, dependent: :destroy
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :name, :code, presence: true

  def to_register?(user_id, key)
    if key == code
      user_team = users_teams.new user_id: user_id
      return user_team.save
    end

    false
  end
end
