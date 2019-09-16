require 'rails_helper'

RSpec.describe API::GalleryController, type: :controller do
  let(:user) { create(:user, :actived) }
  let(:fixture_path) { Rails.root.join('spec', 'fixtures', 'files') }
  let(:json_response) { JSON.parse(response.body) }

  before { sign_in user }

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) {
        {
          upload: File.new("#{fixture_path}/user.png")
        }
      }

      it 'returns the success message after create' do
        allow(Refile).to receive(:attachment_url).and_return('fake-path')

        post :create, params: params

        expect(json_response['url']).to eq('fake-path')
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {{ }}

      it 'returns the error message after try create' do
        post :create, params: params

        expect(json_response['error']['message']).to eq('could not upload this image')
      end
    end
  end
end
