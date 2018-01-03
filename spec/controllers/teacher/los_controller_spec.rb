require 'rails_helper'

RSpec.describe Teacher::LosController, type: :controller do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }

  before { sign_in user }

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) {
        {
          lo: {
            name: 'test',
            description: 'test-description'
          }
        }
      }

      it 'returns the success message after create' do
        post :create, params: params
        
        expect(flash[:success]).to eq 'OA criado com sucesso.'
      end

      it 'returns the success message after update' do
        put :update, params: params.merge({id: lo.id})
        
        expect(flash[:success]).to eq 'OA editado com sucesso.'
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          lo: {
            name: 'test',
            description: nil
          }
        }
      }

      it 'returns the error message after try create' do
        post :create, params: params
        
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end

      it 'returns the error message after try update' do
        post :create, params: params.merge({id: lo.id})
        
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end
    end
  end
end