class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :timeoutable,
         :rememberable, :validatable

  def name
    'Admin'
  end

  def avatar
    '/assets/missing-5eb0bbe7ff82c5cefe277a48c636c0e12e75eef468022fdc29d02dee09c80422.png'
  end
end
