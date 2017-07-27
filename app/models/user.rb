class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :los
  has_many :answers
  has_many :users_teams
  has_many :teams, through: :users_teams
  has_many :my_teams, class_name: "Team"

  validates :name, presence: true

  def registered?(team)
    !teams.find_by(id: team.id).nil?
  end

  def avatar_url(type)
    avatar.url(type)
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
