class TipsCount < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :team
  
end
