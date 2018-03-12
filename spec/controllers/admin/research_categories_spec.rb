require 'rails_helper'

RSpec.describe Admin::ResearchCategoriesController, type: :controller do
  let(:admin) { create(:admin) }

  before { sign_in admin }

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) {
        {
          admin_research_category: {
            name: "test #{Time.now}",
          }
        }
      }

      it 'returns the success message after create' do
        post :create, params: params

        expect(flash[:success]).to eq 'Categoria de pesquisa criada com sucesso.'
      end

      it 'returns the success message after update' do
        pending
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          admin_research_category: {
            name: '',
          }
        }
      }

      it 'returns the error message after try create' do
        post :create, params: params
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end

      it 'returns the error message after try create with name already taken' do
        Admin::ResearchCategory.destroy_all
        category = create(:admin_research_category)
        params[:admin_research_category][:name] = category.name

        post :create, params: params
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end

      it 'returns the error message after try update' do
        pending
        #put :update, params: params.merge({id: lo.id})
        #expect(flash[:error]).to eq 'Existem dados incorretos.'
      end
    end
  end

  describe '#destroy' do
    it 'returns the sucess message after destroy a research category' do
      category = create(:admin_research_category)

      delete :destroy, params: {id: category.id}
      expect(flash[:success]).to eq 'Categoria de pesquisa removida com sucesso.'
    end
  end
end
