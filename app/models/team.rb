class Team < ActiveRecord::Base
  has_many :users_teams
  has_many :los_teams
  has_many :los , through: :los_teams
  has_many :users, through: :users_teams
  belongs_to :user


  def to_register?(id, key)
    user_team = users_teams.new user_id: id

    return true if key == code && user_team.save

    false
  end

  def add_los(data)
    data.each do |key, value|
      lo_team = los_teams.new lo_id: value
      lo_team.save
    end
  end
end
