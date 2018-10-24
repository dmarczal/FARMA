class Question < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :exercise, counter_cache: true
  has_many :tips, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :tips_counts, dependent: :destroy

  validates :correct_answer, :title, :content, presence: true


  delegate :user, to: :exercise

  def answered(team = nil)
    @_answers ||= if team.nil?
                    answers.where(user_id: user, team_id: nil)
                  else
                    answers.where(user_id: user, team_id: team.id)
                  end
  end

  def visualized?(team = nil)
    !answered(team).empty?
  end

  def completed?(team = nil)
    answered(team).exists?(correct: true)
  end

  def tips_to_show(user:, team:, tips_count:)
    @_tips ||= if tips_count.nil?
                 tips.where("number_of_tries <= ?", [tries]) unless have_a_try?
               else
                 tips.where("number_of_tries <= ?", [tips_count])
               end
  end

  private

  def have_a_try?
    !first_tip.nil?
  end

  def tries
    @_tries = first_tip.tries
  end

  def first_tip
    @_tip ||= tips_counts.where(user_id: user.id, team_id: team.id).first
  end
end
