require 'rails_helper'

RSpec.describe Workspace::ExercisesController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
  end

  describe "POST create" do

    context "with valid attributes" do

      it "redirects to the #{@lo} upon save" do
        post :create, lo_id: @lo, exercise: FactoryGirl.attributes_for(:exercise)
        expect(response).to redirect_to [:workspace, @lo]
      end

      it "create a new introduction" do
        expect{
          post :create, lo_id: @lo, exercise: FactoryGirl.attributes_for(:exercise)
        }.to change(Exercise,:count).by(1)
      end

    end

    context "with invalid attributes" do

      it "render to the new upon save" do
        post :create, lo_id: @lo, exercise: FactoryGirl.attributes_for(:invalid_exercise)
        expect(response).to render_template :new
      end

      it "don't shoud create a new introduction" do
        expect{
          post :create, lo_id: @lo, exercise: FactoryGirl.attributes_for(:invalid_exercise)
        }.to_not change(Exercise,:count)
      end

    end
  end

  describe 'DELETE destroy' do
    before :each do
      @exercise = FactoryGirl.create(:exercise, lo: @lo)
    end

    it "should be delete informed introduction" do
      expect{
        delete :destroy, lo_id: @lo, id: @exercise
      }.to change(Exercise,:count).by(-1)
    end

    it "should be redirect to #{@lo}" do
      delete :destroy, lo_id: @lo, id: @exercise
      expect(response).to redirect_to [:workspace, @lo]
    end
  end

  describe "PUT update" do
    before :each do
      @exercise = FactoryGirl.create(:exercise,title: 'title', content: 'content', lo: @lo)
    end

    context 'valid attributes' do

      it "should be redirect to #{@lo}" do
        put :update, lo_id: @lo, id: @exercise, exercise: FactoryGirl.attributes_for(:exercise)
        expect(response).to redirect_to [:workspace, @lo]
      end

      it "should be updated the  attributes" do
        put :update, lo_id: @lo, id: @exercise, introduction: FactoryGirl.attributes_for(:exercise, title: "test", content: "test")
        @exercise.reload
        expect(@exercise.title).to eq "test"
        expect(@exercise.content).to eq "test"
      end

    end

    context 'invalid attributes' do

      it 'should be render the action new' do
          put :update, lo_id: @lo, id: @exercise, exercise: FactoryGirl.attributes_for(:invalid_exercise)
          expect(response).to render_template :edit
      end

      it "should not updated the #{@exercise} attributes" do
        put :update, lo_id: @lo, id: @exercise, exercise: FactoryGirl.attributes_for(:exercise, title: "test", content: nil)
        @exercise.reload
        expect(@exercise.title).to eq "title"
        expect(@exercise.content).to eq "content"
      end

    end

  end
end
