require 'rails_helper'
require 'pp'

RSpec.describe Api::QuestionsController, type: :controller do

  describe "GET 'index' " do
    let!(:question) { FactoryBot.create_list(:question, 5) }

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
    let!(:question) { FactoryBot.create(:question) }

    it "returns a successful 200 response" do
      get :show, params: {id: question.id}, format: :json
      expect(response).to be_success
    end

    it "returns data of an single question" do
      get :show, params: {id: question.id}, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to_not be_nil
    end

    it "returns an error if the question does not exist" do
      get :show, params: {id: 2} , format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq("Question does not exist")
    end

  end

  describe "POST 'create' " do
    context "correct question format" do
      it "returns a successful json string with success message" do
        post :create, params: { title: "newstudent@example.com",content: "xxxxxx" ,correct_answer: 5}
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['success']).to eq( "Question successfully created")
      end
    end

    context "incorrect question format" do
      it "returns a error json string with error message" do
        post :create, params: { title: "",content: "" ,correct_answer: ""}
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq("Error creating question")
      end
    end
  end

  describe "PUT 'update' " do
    let!(:question) { FactoryBot.create(:question) }
    it "return a successful json string" do
      put :update, params: { id: question.id, title: 'update', content: 'update', correct_answer: 1000}
      parsed_response = JSON.parse(response.body)
      pp parsed_response
      expect(parsed_response['success']).to eq( "Question successfully update")
    end

  end

end
