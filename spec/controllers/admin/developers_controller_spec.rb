require 'rails_helper'

RSpec.describe Admin::DevelopersController, type: :controller do
	
  let(:admin) { FactoryBot.create(:admin) }
  before { sign_in admin }
  let(:admin_developer) { FactoryBot.create(:admin_developer)}

	describe '#create' do 
	
		context 'when all parameters sent are valid and developer is active' do
			let(:params) {
				{
					admin_developer: {
						name: "#{Faker::Name.name}",
						function: "#{Faker::Job.title}",
						institution: "#{Faker::Educator.university}",
						link: "#{Faker::Internet.url}",
						active: true,
						start_on_project: "#{Faker::Date.between(30.days.ago, Date.today)}",
					}
				}
			}
			it 'returns the success message after create' do
				post :create, params: params

				expect(flash[:success]).to eq 'Desenvolvedor adicionado com sucesso.'
			end

			it 'returns the success message after update' do
				put :update, params: params.merge({id: admin_developer.id})
				
				expect(flash[:success]).to eq 'Desenvolvedor editado com sucesso.'
			  end
		end

		context 'when all parameters sent are valid and developer is no more active' do
			let(:params) {
				{
					admin_developer: {
						name: "#{Faker::Name.name}",
						function: "#{Faker::Job.title}",
						institution: "#{Faker::Educator.university}",
						link: "#{Faker::Internet.url}",
						active: false,
						start_on_project: "#{Faker::Date.between(30.days.ago, 20.days.ago)}",
						leave_project: "#{Faker::Date.between(19.days.ago, Date.today)}",
					}
				}
			}
			it 'returns the success message after create' do
				post :create, params: params

				expect(flash[:success]).to eq 'Desenvolvedor adicionado com sucesso.'
			end
			 
		end

		context 'when all parameters sent are valid except leave project and developer is no more active' do
			let(:params) {
				{
					admin_developer: {
						name: "#{Faker::Name.name}",
						function: "#{Faker::Job.title}",
						institution: "#{Faker::Educator.university}",
						link: "#{Faker::Internet.url}",
						active: false,
						start_on_project: "#{Faker::Date.between(30.days.ago, 20.days.ago)}",
					}
				}
			}
			it 'returns the error message after create' do
				post :create, params: params

				expect(flash[:error]).to eq 'Existem dados incorretos.'
			end
		end
		
		context 'when one or more parameters sent are invalid' do
			let(:params) {
				{
					admin_developer: {
						name: "",
						function: "#{Faker::Job.title}",
						institution: "#{Faker::Educator.university}",
						link: "http_error",
						active: true,
						start_on_project: "#{Faker::Date.between(30.days.ago, 20.days.ago)}",
					}
				}
			}
			it 'returns the error message after create' do
				post :create, params: params

				expect(flash[:error]).to eq 'Existem dados incorretos.'
			end
		end

	end
end
