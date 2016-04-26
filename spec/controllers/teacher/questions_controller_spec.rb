require 'rails_helper'

RSpec.describe Workspace::QuestionsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
  end

  describe 'DELETE destroy' do
    before :each do
      @question = FactoryGirl.create(:question, exercise: @exercise)
    end

    it "should delete the question" do
      expect{
        delete :destroy, lo_id: @lo, exercise_id: @exercise, id: @question
      }.to change(Question,:count).by -1
    end

    it "should redirect to the exercise path" do
      delete :destroy, lo_id: @lo, exercise_id: @exercise, id: @question
      expect(response).to redirect_to [:workspace, @lo, @exercise]
    end

  end

  describe "PUT update" do
    before :each do
      @question = FactoryGirl.create(:question,title: 'title', content: 'content', exercise: @exercise)
    end

    context 'valid attributes' do

      it "should update the attributes" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:question, title: "test", content: "test")
        @question.reload
        expect(@question.title).to eq "test"
        expect(@question.content).to eq "test"
      end

      it "should redirect to the exercise path" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:question, title: "test", content: "test")
        expect(response).to redirect_to [:workspace, @lo, @exercise]
      end

    end
  end
end
