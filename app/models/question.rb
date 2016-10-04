class Question < ActiveRecord::Base
  include AuthenticationAndPosition

  belongs_to :exercise, counter_cache: true
  has_many :tips, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :tips_counts, dependent: :destroy

  validates :correct_answer, presence: true

  def answered(user, team)
    @answers_to_show ||= answers.where(user_id: user, team_id: team)
  end

  def tips_to_show(options = [])
    return @tips unless @tips.nil?

    if options[:tips_count].nil?
      tips_count = tips_counts.where(user_id: options[:user], team_id: options[:team], question_id: self)

      unless tips_count[0].nil?
        options[:tips_count] = tips_count[0].tries
      else
        return nil
      end
    end

    return @tips ||= tips.where("number_of_tries <= #{options[:tips_count]}")
  end
end
