class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :progress_los, dependent: :destroy, class_name: 'Progress::Lo'
  has_one  :image, class_name: "Picture", as: :subject
  has_one :team, dependent: :nullify
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :image

  validates :name, :description, :user, presence: true

  # scopes
  scope :available, -> { where(available: true) }
  scope :find_with_like, ->(query) { where('name LIKE ?', "%#{query}%") }
  # scopes-end

  def progress_lo(team)
    @progress_los ||= progress_los.find_by(team_id: team.id, user_id: user.id)
  end

  def progress_percent(team)
    progress = progress_lo(team)
    progress.nil? ? 0 : progress.progress_percent
  end

  def preview_percent(team)
    progress = progress_lo(team)
    progress.nil? ? 0 : progress.preview_percent
  end

  def content_by_position(index)
    contents[index.to_i - 1]
  end

  def update_los_teams
    los_progress = Progress::lo.find_by lo_id: self.id

    los_progress.each do |lo_progress|
      lo_progress.recalc
    end
  end

  # Mescla de introduções e exercícios
  def contents
    return @contents unless @contents.nil?

    exercises = self.exercises.order(:position).includes :questions
    introductions = self.introductions.order :position
    exercises = define_index_method_for_questions exercises

    @contents = exercises + introductions
    @contents = @contents.sort_by { |o| o.position }
    define_index_method_for_contents

    @contents
  end

  private

  # This is necessary to show exercise and introduction order independently
  def define_index_method_for_contents
    i, e = 0, 0
    @contents.each do |content|
      def content.index
        @index
      end

      def content.index=(index)
        @index = index
      end

      if content.instance_of? Introduction
        i += 1
        content.index= i
      else
        e += 1
        content.index= e
      end
    end
  end

  def define_index_method_for_questions(exercises)
    exercises.each do |exercise|
      q = 0

      exercise.questions.each do |question|
        def question.index
          @index_q
        end

        def question.index=(index)
          @index_q = index
        end

        q += 1
        question.index= q
      end
    end

    exercises
  end
end
