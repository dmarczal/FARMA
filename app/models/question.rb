class Question < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :exercise, counter_cache: true
  has_many :tips, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :tips_counts, dependent: :destroy

  validates :correct_answer,
            :title,
            :content,
            :answer_tex,
            presence: true

  validates :precision,
            numericality: { only_integer: true, less_than: 6, greater_than: 0 },
            allow_nil: true

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

  def tips_to_show(user: nil, team: nil, tips_count: nil)
    @_tips ||= if tips_count.nil?
                 tips.where("number_of_tries <= ?", [tries(user, team)]) if have_a_try?(user, team)
               else
                 tips.where("number_of_tries <= ?", [tips_count])
               end
  end

  private

  def have_a_try?(user, team)
    !first_tip(user, team).nil?
  end

  def tries(user, team)
    return @_tries if @_tries

    first_tip = first_tip(user, team)
    return 0 if (first_tip.nil?)

    @_tries = first_tip.tries
  end

  def first_tip(user, team)
    @_tip ||= tips_counts.find_by(user_id: user.id, team_id: team.id)
  end
end
