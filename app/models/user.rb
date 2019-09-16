class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :los
  has_many :answers
  has_many :users_teams
  has_many :teams, through: :users_teams
  has_many :my_teams, class_name: 'Team'
  has_many :ck_images, dependent: :destroy
  has_one  :avatar, class_name: 'Picture', as: :subject

  accepts_nested_attributes_for :avatar

  validates :name, presence: true

  def registered?(team)
    !teams.find_by(id: team.id).nil?
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
