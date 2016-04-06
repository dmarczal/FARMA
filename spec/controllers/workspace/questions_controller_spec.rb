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
      it "redireciona para exercicio" do
        post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to [:workspace, @lo, @exercise]
      end

      it "cria uma nova questão " do
        expect{
          post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:question)
        }.to change(Question,:count).by 1
      end
    end

    context "with invalid attributes" do
      it "renderiza o new da questão" do
        post :create, lo_id: @lo, exercise_id: @exercise, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :new
      end

      it "não cria a nova questão" do
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

    it "deve deletar a questão" do
      expect{
        delete :destroy, lo_id: @lo, exercise_id: @exercise, id: @question
      }.to change(Question,:count).by -1
    end

    it "deve redirecionar para o exercise" do
      delete :destroy, lo_id: @lo, exercise_id: @exercise, id: @question
      expect(response).to redirect_to [:workspace, @lo, @exercise]
    end

  end

  describe "PUT update" do
    before :each do
      @question = FactoryGirl.create(:question,title: 'title', content: 'content', exercise: @exercise)
    end

    context 'valid attributes' do

      it "atributos atualizados" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:question, title: "test", content: "test")
        @question.reload
        expect(@question.title).to eq "test"
        expect(@question.content).to eq "test"
      end

      it "deve redirencionar para o exercicio" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:question, title: "test", content: "test")
        expect(response).to redirect_to [:workspace, @lo, @exercise]
      end

    end

    context 'invalid attributes' do

      it "os atributos não devem ser atualizados" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:invalid_question)
        @question.reload
        expect(@question.title).to eq "title"
        expect(@question.content).to eq "content"
      end

      it "deve renderizar o edit" do
        put :update, lo_id: @lo, exercise_id: @exercise, id: @question, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template :edit
      end
    end

  end

end
