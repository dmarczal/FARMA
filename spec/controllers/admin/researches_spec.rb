require 'rails_helper'

RSpec.describe Admin::ResearchesController, type: :controller do
  let(:admin) { create(:admin) }
  let(:research_category) { create(:admin_research_category) }
  let(:research) { create(:admin_research) }

  before { sign_in admin }

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) do
        {
          admin_research: {
            title: "test #{Time.now}",
            ref: "new ref #{Faker::Date.between(2.days.ago, Date.today)}",
            abstract: Faker::Lorem.paragraph(3),
            link: Faker::Internet.url,
            research_category_id: research_category.id
          }
        }
      end

      it 'returns the success message after create' do
        post :create, params: params

        expect(flash[:success]).to eq 'Pesquisa criada com sucesso.'
      end

      it 'returns the success message after update' do
        put :update, params: params.merge(id: research.id)

        expect(flash[:success]).to eq 'Pesquisa atualizada com sucesso.'
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) do
        {
          admin_research: {
            title: "test #{Time.now}",
            ref: "new ref #{Faker::Date.between(2.days.ago, Date.today)}",
            abstract: Faker::Lorem.paragraph(3),
            link: 'http_error',
            research_category_id: 'this should not be string'
          }
        }
      end

      it 'returns the error message after try create' do
        post :create, params: params

        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end

      it 'returns the error message after try update' do
        put :update, params: params.merge(id: research.id)

        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end

      it 'returns the error message after try create with name already taken' do
        Admin::Research.destroy_all
        category = create(:admin_research_category)
        research = create(:admin_research)
        params[:admin_research][:title] = research.title
        params[:admin_research][:ref] = research.ref
        params[:admin_research][:abstract] = research.title
        params[:admin_research][:link] = research.title
        params[:admin_research][:research_category_id] = category.id

        post :create, params: params
        expect(flash[:error]).to eq 'Existem dados incorretos.'
      end
    end
  end

  describe '#destroy' do
    it 'returns the sucess message after destroy a research category' do
      research = create(:admin_research)
      delete :destroy, params: { id: research.id }
      expect(flash[:success]).to eq 'Pesquisa removida com sucesso.'
    end
  end
end
