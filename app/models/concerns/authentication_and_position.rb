module AuthenticationAndPosition
  extend ActiveSupport::Concern

  included do
    validates :title, :content, presence: true
    before_create :default_position
  end

  private
    def default_position
      self.position = Time.now
    end
end
