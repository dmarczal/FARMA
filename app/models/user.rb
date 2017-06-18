class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :los
  has_many :answers
  has_many :users_teams
  has_many :teams, through: :users_teams
  has_many :my_teams, class_name: "Team"

  has_attached_file :avatar, :styles => {:thumb => "55x55^", :medium => "400x400^"}, default_url: "missing.png"

  validates :name, presence: true
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def registered?(team)
    teams.find_by id: team.id
  end

  def register(params)
    team = Team.find params[:id]

    if team.correct_code? params[:code]
      teams << team
      return true
    end

    false
  end
end
