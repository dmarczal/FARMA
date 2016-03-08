require 'rails_helper'

RSpec.describe Introduction, type: :model do
  before do
    @user = FactoryGirl.create(:user_actived)
    @lo = FactoryGirl.create(:lo, user: @user)
    @intro = FactoryGirl.create(:introduction, lo: @lo)
  end

  context "invalid attributes" do
    it "should not be save in the table with null title"do
      @intro.title = ''
      expect(@intro.save).to eq false
    end

    it "should not be save in the table with null content"do
      @intro.content = ''
      expect(@intro.save).to eq false
    end
  end

end
