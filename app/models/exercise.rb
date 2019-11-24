class Exercise < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :lo, counter_cache: true
  has_many :questions, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :lo, presence: true

  delegate :user, to: :lo

  def link_steps(team, user)
    questions.map do |question|
      answers = question.answers.where(user_id: user, team_id: team)
      return nil if answers.nil?

      answers.last&.correct
    end
  end
end
