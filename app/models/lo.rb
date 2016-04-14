class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy

  validates :name, :description, :user, presence: true

  # Mescla de introduções e exercícios
  def contents
    exercises = self.exercises.order :position
    introductions = self.introductions.order :position

    contents = exercises + introductions
    contents.sort{|a, b| a.position <=> b.position}
  end
end
