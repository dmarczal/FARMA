class Contact < ActiveRecord::Base
  validates :name, :message, :email, presence: true
  validates_format_of :email,:with => Devise.email_regexp
end
