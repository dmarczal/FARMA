class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :teams
  has_many :progress_lo
  has_attached_file :image, :styles => {:thumb => '200x200!'},
                      default_url: "home/oa.png"

  validates :name, :description, :user, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def content_by_position(index)
    content = contents[index.to_i - 1]
  end

  # Mescla de introduções e exercícios
  def contents
    return @contents unless @contents.nil?

    exercises = self.exercises.order(:position).includes :questions
    introductions = self.introductions.order :position
    exercises = define_index_method_for_questions exercises

    @contents = exercises + introductions
    @contents = @contents.sort {|a, b| a.position <=> b.position}
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
