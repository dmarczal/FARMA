require 'rails_helper'

describe "the signin process" do
  include FormHelpers

  before :each do
    @user = FactoryGirl.create(:user_actived)
  end

  it "signs me in" do
    visit new_user_session_path

    filds = {'user_email' => @user.email,'user_password' => @user.password}
    fill_in_form filds, ".simple_form"

    expect(page.current_path).to eq teacher_path
  end
end
