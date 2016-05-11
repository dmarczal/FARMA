require 'rails_helper'

RSpec.describe Teacher::TipsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
    @exercise = FactoryGirl.create(:exercise, lo: @lo)
    @question = FactoryGirl.create(:question, exercise: @exercise)
  end

  describe "POST create" do

    context "with valid attributes" do
      it "should the redirect to exercise path" do
        post :create, lo_id: @lo, exercise_id: @exercise, question_id: @question, tip: FactoryGirl.attributes_for(:tip)
        expect(response).to redirect_to [:workspace, @lo, @exercise]
      end

      it "should create a new Tip" do
        expect{
          post :create, lo_id: @lo, exercise_id: @exercise, question_id: @question, tip: FactoryGirl.attributes_for(:tip)
        }.to change(Tip,:count).by 1
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @tip = FactoryGirl.create(:tip, question: @question)
    end


    it "should delete the tip" do
      expect{
        delete :destroy, lo_id: @lo, exercise_id: @exercise, question_id: @question, id: @tip
      }.to change(Tip,:count).by -1
    end

    it "should redirect to the exercise path" do
      delete :destroy, lo_id: @lo, exercise_id: @exercise, question_id: @question, id: @tip
      expect(response).to redirect_to [:workspace, @lo, @exercise]
    end

  end

  describe "PUT update" do
    before :each do
      @tip = FactoryGirl.create(:tip, content: 'content', question: @question)
    end

    context 'valid attributes' do

      it "should update the attributes" do
        put :update, lo_id: @lo, exercise_id: @exercise, question_id: @question,
              id: @tip, tip: FactoryGirl.attributes_for(:tip, content: "test")

        @tip.reload
        expect(@tip.content).to eq "test"
      end

      it "should redirect to the exercise path" do
        put :update, lo_id: @lo, exercise_id: @exercise, question_id: @question,
              id: @tip, tip: FactoryGirl.attributes_for(:tip, content: "test")
        expect(response).to redirect_to [:workspace, @lo, @exercise]
      end

    end
  end

end
