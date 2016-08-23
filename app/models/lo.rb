class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introductions, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_attached_file :image, :styles => {:thumb => '200x200!'},
                      default_url: "home/oa.png"

  validates :name, :description, :user, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Mescla de introduções e exercícios
  def contents
    exercises = self.exercises.order :position
    introductions = self.introductions.order :position

    @contents = exercises + introductions
    define_index_method_for_contents
    @contents.sort {|a, b| a.position <=> b.position}
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
end
