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

  context "invalid attributes" do

    it "should not be stored in the table with null name" do
      @lo.name = nil
      expect(@lo.save).to eq false
    end

    it "should not be stored in the table with null description" do
      @lo.description = nil
      expect(@lo.save).to eq false
    end
  end

  it "contents lo position" do
    allow_any_instance_of(Exercise).to receive(:default_position)
    allow_any_instance_of(Introduction).to receive(:default_position)


    exercise1 = FactoryGirl.create(:exercise, lo: @lo,
                                   position: 1.second.from_now.to_i)

    introduction1 = FactoryGirl.create(:introduction, lo: @lo,
                                       position: 2.second.from_now.to_i)

    exercise2 = FactoryGirl.create(:exercise, lo: @lo,
                                   position: 3.second.from_now.to_i)

    introduction2 = FactoryGirl.create(:introduction, lo: @lo,
                                       position: 4.second.from_now.to_i)

    contents = @lo.contents

    expect(contents[0]).to eq exercise1
    expect(contents[1]).to eq introduction1
    expect(contents[2]).to eq exercise2
    expect(contents[3]).to eq introduction2
  end

  it "should destroy intructions and exercises related" do
      FactoryGirl.create(:exercise, lo: @lo)
      FactoryGirl.create(:introduction, lo: @lo)

      @lo.destroy

      expect(Introduction.count).to eq 0
      expect(Exercise.count).to eq 0
  end
end
