class LosTeam < ActiveRecord::Base
  belongs_to :lo
  belongs_to :team

  validates_uniqueness_of :lo_id, scope: :team_id
end
