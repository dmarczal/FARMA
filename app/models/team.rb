class Team < ActiveRecord::Base
  has_many :users_teams, dependent: :destroy
  has_many :los_teams, dependent: :destroy
  has_many :los , through: :los_teams
  has_many :users, through: :users_teams
  has_many :tips_counts, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :progress_lo, class_name: "Progress::Lo"
  belongs_to :user

  validates :name, :code, presence: true

  # scopes

  scope :opened_and_not_registered, ->(user) {
    joins(:users_teams).where('"teams"."opened" = ? AND "users_teams"."user_id" != ?', '1', user.id)
  }

  def correct_code?(code)
    self.code == code
  end

  def register_lo(lo)
    unless los_teams.exists? lo_id: lo
      los_teams.create(lo_id: lo)
    end
  end

  def create_lo_progress(lo, user)
    progress = progress_lo.find_by lo_id: lo, user_id: user

    return progress_lo.create user: user, lo: lo if progress.nil?

    progress
  end

end
