require 'rails_helper'

describe 'the signin process' do
  let!(:user) { create(:user, :actived) }
  let(:params) {
    {
      'user_email' => user.email,
      'user_password' => user.password
    }
  }

  it 'signs me in' do
    visit new_user_session_path

    fill_in_form '.simple_form', params

    expect(page.current_path).to eq workspace_path
  end
end
