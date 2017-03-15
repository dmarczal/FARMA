class Progress::Lo < ::ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  belongs_to :lo, class_name: "::Lo"

  validates :team, :lo, :user, presence: true

  def recalc
    total = lo.introductions_count + lo.exercises_count
    self.preview_percent = 0
    self.progress_percent = 0
    introductions = Progress::Introduction.where team_id: team_id, user_id: user_id
    exercises = Progress::Exercise.where team_id: team_id, user_id: user_id

    introductions.each do
      self.preview_percent += 1.0/total * 100
    end

    exercises.each do |e|
      self.preview_percent += e.preview_percent/total
      self.progress_percent += e.progress_percent/lo.exercises_count
    end

    round_progress
    save!
  end

  def previewed_an_introduction(introduction)
    unless Progress::Introduction.exists? introduction_id: introduction, user_id: user_id, team_id: team_id
      Progress::Introduction.create! introduction_id: introduction.id, user_id: user_id, team_id: team_id

      total = lo.introductions_count + lo.exercises_count
      self.preview_percent += 1.0/total * 100

      round_progress
      save!
    end
  end

  def previewed_an_exercise(answer)
    total = lo.introductions_count + lo.exercises_count
    progress = Progress::Exercise.find_or_create_by(exercise_id: answer.question.exercise_id,
                                                    user_id: user_id,
                                                    team_id: team_id)

    self.preview_percent -= progress.preview_percent/total
    self.progress_percent -= progress.progress_percent/lo.exercises_count

    progress.set_progress answer

    self.preview_percent += progress.preview_percent/total
    self.progress_percent += progress.progress_percent/lo.exercises_count

    round_progress
    save!
  end

  def round_progress
    self.preview_percent = self.preview_percent.round
    self.progress_percent = self.progress_percent.round
  end
end
