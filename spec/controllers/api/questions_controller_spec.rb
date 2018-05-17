require 'rails_helper'
require 'pp'

RSpec.describe API::QuestionsController, type: :controller do

  describe "GET 'index' " do
    let!(:question) {FactoryBot.create_list(:question, 5)}

    it "returns a successful 200 response" do
      get :index, format: :json
      expect(response).to be_success
    end

    it "returns all the questions" do
      get :index, format: :json
      body = JSON.parse(response.body)
      expect(body.size).to eq(5)
    end
  end

  describe "GET 'show' " do
    let!(:question) {FactoryBot.create(:question)}
    it "returns a successful 200 response" do
      get :show, params: {id: question.id}, format: :json
      expect(response).to be_success
    end

    it "returns data of an single question" do
      get :show, params: {id: question.id}, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to_not be_nil
    end
  end

  describe "POST 'create' " do
    let!(:exercise) {FactoryBot.create(:exercise)}
    context "correct question format" do
      it "returns a successful json string with success message" do
        post :create, params: {title: "newstudent@example.com", content: "xxxxxx", correct_answer: 5, exercise_id: exercise.id}
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq("newstudent@example.com criada com sucesso.")
      end
    end

    context "incorrect question format" do
      it "returns a error json string with error message" do
        post :create, params: {title: "", content: "", correct_answer: "", exercise_id: exercise.id}
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq("Erro ao criar a questão.")
      end
    end
  end

  describe "PUT 'update' " do
    let!(:question) {FactoryBot.create(:question)}
    let!(:exercise) {FactoryBot.create(:exercise)}
    it "return a error json string" do
      put :update, params: {id: question.id, title: 'update', content: 'update', correct_answer: 1000, exercise_id: exercise.id}
      parsed_response = JSON.parse(response.body)
      pp parsed_response
      expect(parsed_response['message']).to eq("update atualizada com sucesso.")
    end

    it "return a successful json string" do
      put :update, params: {id: question.id, title: '', content: '', correct_answer: "", exercise_id: exercise.id}
      parsed_response = JSON.parse(response.body)
      pp parsed_response
      expect(parsed_response['message']).to eq("Erro ao atualizar a questão.")
    end
  end
end
