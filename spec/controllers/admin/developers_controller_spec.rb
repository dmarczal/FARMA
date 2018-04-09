require 'rails_helper'

RSpec.describe Admin::DevelopersController, type: :controller do
  let(:admin) { create(:admin, :actived) }
  let(:developer) { create(:developer, admin: admin) }


describe '#create' do
  context 'When all parameters are valid' do 
  	let(:params) {
  		{
  			developer: {
  				name: 'Developer'
  				function: 'Web Developer'
  				institution: 'UTFPR'
  				link: 'www.utfpr.edu.br'
  				start_on_project: '26-03-2018'
  				active: true
  			}
  		}
  	}

  	it 'returns the success message after create' do
  		post :create, params: params
        
        expect(flash[:success]).to eq 'Desenvolvedor adicionado com sucesso.'
  	end
  end
end

end
