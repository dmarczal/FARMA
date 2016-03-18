require 'rails_helper'

RSpec.describe Exercise, type: :model do

  before do
    @user = FactoryGirl.create(:user_actived)
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
  end

  context "invalid attributes" do
    it "should not be save in the table with null title"do
      @exercise.title = ''
      expect(@exercise.save).to eq false
    end

    it "should not be save in the table with null content"do
      @exercise.content = ''
      expect(@exercise.save).to eq false
    end
  end

end
