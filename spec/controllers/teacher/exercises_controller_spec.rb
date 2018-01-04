require 'rails_helper'

RSpec.describe Teacher::ExercisesController, type: :controller do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }
  let(:exercise) { create(:exercise, lo: lo) }

  before { sign_in user }

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) {
        {
          lo_id: lo.id,
          exercise: {
            title: 'test',
            content: 'test-description'
          }
        }
      }

      it 'returns the success message after create' do
        post :create, params: params
        
        expect(flash[:success]).to eq 'Exercício criado com sucesso.'
      end

      it 'returns the success message after update' do
        put :update, params: params.merge({id: exercise.id})
        
        expect(flash[:success]).to eq 'Exercício editado com sucesso.'
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          lo_id: lo.id,
          exercise: {
            title: 'test',
            content: nil
          }
        }
      }

      it 'returns the error message after try create' do
        post :create, params: params
        
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end

      it 'returns the error message after try update' do
        put :update, params: params.merge({id: exercise.id})
        
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end
    end
  end
end