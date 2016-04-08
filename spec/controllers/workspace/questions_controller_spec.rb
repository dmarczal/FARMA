require 'rails_helper'

RSpec.describe Workspace::QuestionsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
  end

  describe "POST create" do
    context "with valid attributes" do
      it "should the redirect to exercise path" do
        post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to [:workspace, @lo, @exercise]
      end

      it "should create a new Question" do
        expect{
          post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:question)
        }.to change(Question,:count).by 1
      end
    end

    context "with invalid attributes" do
      it "should render the new question" do
        post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :new
      end

      it "should not create the new Question" do
        expect{
            post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:invalid_question)
        }.to_not change(Question,:count)
      end
    end
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

    context 'invalid attributes' do

      it "should not update the attributes" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:invalid_question)
        @question.reload
        expect(@question.title).to eq "title"
        expect(@question.content).to eq "content"
      end

      it "should render the edit of question" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :edit
      end
    end
  end
end
