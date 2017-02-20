class Progress::Lo < ::ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  belongs_to :lo, class_name: "::Lo"

  validates :team, :lo, :user, presence: true

  def recalc
    total = lo.introductions_count + lo.exercises_count
    data = {preview_percent: 0, progress_percent: 0}
    introductions = Progress::Introduction.where team_id: team_id, user_id: user_id

    introductions.each do
      data[:progress_percent] += 1.0/total * 100
      data[:preview_percent] += 1.0/total * 100
    end

    exercises = Progress::Exercise.where team_id: team_id, user_id: user_id

    exercises.each do |e|
      data[:preview_percent] += e.preview_percent/total
      data[:progress_percent] += e.progress_percent/total
    end

    round_progress data
    update data
  end

  def previewed_an_introduction(introduction)
    unless Progress::Introduction.exists? introduction_id: introduction, user_id: user_id, team_id: team_id
      data = {preview_percent: preview_percent, progress_percent: progress_percent}
      Progress::Introduction.create! introduction_id: introduction.id, user_id: user_id, team_id: team_id

      total = lo.introductions_count + lo.exercises_count
      data[:progress_percent] += 1.0/total * 100
      data[:preview_percent] += 1.0/total * 100

      round_progress data
      update data
    end
  end

  def previewed_an_exercise(answer)
    total = lo.introductions_count + lo.exercises_count

    data = {preview_percent: preview_percent, progress_percent: progress_percent}

    progress = Progress::Exercise.find_or_create_by(exercise_id: answer.question.exercise_id,
                                                    user_id: user_id,
                                                    team_id: team_id)

    data[:preview_percent] -= progress.preview_percent/total
    data[:progress_percent] -= progress.progress_percent/total

    progress.set_progress answer

    data[:preview_percent] += progress.preview_percent/total
    data[:progress_percent] += progress.progress_percent/total

    round_progress data
    update data
  end

  def round_progress(data)
    data[:progress_percent] = data[:progress_percent].round
    data[:preview_percent] = data[:preview_percent].round
  end
end
