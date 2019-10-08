require 'rails_helper'

RSpec.describe API::QuestionsController, type: :controller do
  let!(:exercise) { create(:exercise) }
  let!(:questions) { create_list(:question, 10, exercise: exercise) }
  let(:question) { questions.first }
  let(:json_response) { JSON.parse(response.body) }
  let(:question_params) { attributes_for(:question, exercise: exercise) }
  subject { response }

  before { create_list(:question, 5) }

  describe "GET 'index'" do
    before { get :index, format: :json, params: { exercise_id: exercise.id } }

    it { is_expected.to be_success }
    it { is_expected.to match_response_schema('questions') }

    it "returns all the questions" do
      expect(json_response["data"].size).to eq(10)
    end
  end

  describe "GET 'show'" do
    context "when request was successful" do
      before { get :show, params: { id: question.id, exercise_id: exercise.id }, format: :json }

      it { is_expected.to be_success }
      it { is_expected.to match_response_schema("question") }

      it "returns the correct question" do
        expect(json_response["data"]['id']).to eq question.id
      end
    end

    context "when question not found" do
      before { get :show, params: { id: 1000, exercise_id: exercise.id }, format: :json }

      it { is_expected.to be_not_found }
      it { is_expected.to match_response_schema("http_error") }
    end
  end

  describe "POST 'create'" do
    context "when the all parameters will be correct" do
      before { post :create, params: question_params.merge({exercise_id: exercise.id}) }

      it { is_expected.to be_created }
      it { is_expected.to match_response_schema("question") }

      it "returns the created question" do
        expect(json_response['data']['title']).to eq question_params[:title]
      end
    end

    context "when any of the parameters will be incorrect or missing" do
      before { post :create, params: { exercise_id: exercise.id } }

      it { is_expected.to be_bad_request }
      it { is_expected.to match_response_schema("error") }
    end
  end

  describe "PUT 'update'" do
    let(:update_question_params) { question_params.merge({ exercise_id: exercise.id, id: question.id }) }

    context "when the all parameters will be correct" do
      before { put :update, params: update_question_params }

      it { is_expected.to be_created }
      it { is_expected.to match_response_schema("question") }

      it "returns the created question" do
        expect(json_response['data']['title']).to eq question_params[:title]
      end
    end

    context "when any of the parameters will be incorrect or missing" do
      before { put :update, params: { exercise_id: exercise.id, id: question.id, title: '', content: '', correct_answer: "" } }

      it { is_expected.to be_bad_request }
      it { is_expected.to match_response_schema("error") }
    end
  end

  describe "DELETE 'destroy'" do
    before { delete :destroy, params: { exercise_id: exercise.id, id: question.id } }

    it { is_expected.to be_ok }
    it { is_expected.to match_response_schema("message") }

    it "returns the message of the deleted question" do
      expect(json_response['data']).to eq "Questão #{question.title} deletada com sucesso"
    end
  end
end
