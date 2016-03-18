require 'rails_helper'

RSpec.describe Lo, type: :model do
  before do
    @user = FactoryGirl.create(:user_actived)
    @lo = FactoryGirl.create(:lo, user: @user)
  end

  context "relationship" do

    it "auto increment in introduction_count when create one new introduction" do
      intro = FactoryGirl.create(:introduction, lo: @lo)
      expect(@lo.introductions_count).to eq 1
    end

    it "auto increment in introduction_count when create one new introduction" do
      exercise = FactoryGirl.create(:exercise, lo: @lo)
      expect(@lo.exercises_count).to eq 1
    end

  end

  context " invalid attributes" do

    it "should not be stored in the table with null name" do
      @lo.name = nil
      expect(@lo.save).to eq false
    end

    it "should not be stored in the table with null description" do
      @lo.description = nil
      expect(@lo.save).to eq false
    end

  end
end
