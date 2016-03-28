class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introduction

  has_many :exercise

  validates :name, :description, :user, presence: true


  def order_contents
    exercises = self.exercise.order :position
    introductions = self.introduction.order :position

    contents = exercises + introductions

    contents.sort{|a, b| a.position <=> b.position}
  end
end
