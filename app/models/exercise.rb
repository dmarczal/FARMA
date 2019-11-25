class Exercise < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :lo, counter_cache: true
  has_many :questions, dependent: :destroy
  has_and_belongs_to_many :tags

  validates :lo, presence: true

  delegate :user, to: :lo

  def link_test_steps(answers)
    questions.map do |question|
      answers[question.id.to_s].last['correct'] if !answers[question.id.to_s].nil? && !answers[question.id.to_s].last.nil?
    end
  end

  def link_steps(team, user)
    questions.map do |question|
      answers = question.answers.where(user_id: user, team_id: team)
      answers.last&.correct if !answers.nil?
    end
  end
end
