class Progress::Introduction < ::ActiveRecord::Base
  belongs_to :user
  belongs_to :introduction, class_name: "::Introduction"
  belongs_to :team

  validates :team_id, :introduction_id, :user_id, presence: true
end
