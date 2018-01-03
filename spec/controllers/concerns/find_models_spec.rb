require 'rails_helper'

RSpec.describe DummiesController, type: :controller do
  controller do
    include FindModels

    before_action :find_lo, only: :lo
    before_action :find_exercise, only: :exercise
    before_action :find_question, only: :question

    def lo
      render json: @lo
    end

    def exercise
      render json: @exercise
    end

    def question
      render json: @question
    end
  end

  let(:user) { lo.user }
  let(:json_response) { JSON.parse response.body }

  before do 
    routes.draw do 
      get 'dummies' => 'dummies#lo'
      get 'dummies' => 'dummies#exercise'
      get 'dummies' => 'dummies#question'
    end

    sign_in user 
  end

  describe 'find_lo' do 
    let(:lo) { create(:lo) }
    let(:params) { { id: lo.id } }

    it "it's calling" do
      expect(subject).to receive(:find_lo)
      get :lo, params: params
    end

    it 'returns the correct lo' do
      get :lo, params: params
      
      expect(json_response).to eq JSON.parse(lo.to_json)
    end
  end

  describe 'find_exercise' do 
    let(:exercise) { create(:exercise) }
    let(:lo) { exercise.lo }

    let(:params) { 
      { 
        lo_id: lo.id,
        id: exercise.id
      }
    }

    it "it's calling" do
      expect(subject).to receive(:find_exercise)

      get :exercise, params: params
    end

    it 'returns the correct exercise' do
      get :exercise, params: params
      
      expect(json_response).to eq JSON.parse(exercise.to_json)
    end
  end

  describe 'find_question' do 
    let(:question) { create(:question) }
    let(:exercise) { question.exercise }
    let(:lo) { exercise.lo }

    let(:params) { 
      { 
        lo_id: lo.id,
        exercise_id: exercise.id,
        id: question.id
      }
    }

    it "it's calling" do
      expect(subject).to receive(:find_question)

      get :question, params: params
    end

    it 'returns the correct question' do
      get :question, params: params
      
      expect(json_response).to eq JSON.parse(question.to_json)
    end
  end
end