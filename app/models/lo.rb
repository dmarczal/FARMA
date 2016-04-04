class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introductions

  has_many :exercises

  validates :name, :description, :user, presence: true


  def order_contents
    exercises = self.exercises.order :position
    introductions = self.introductions.order :position

    contents = exercises + introductions

    contents.sort{|a, b| a.position <=> b.position}
  end
end
