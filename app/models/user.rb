class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_attached_file :avatar, default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
