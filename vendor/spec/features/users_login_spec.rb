require 'rails_helper'

describe "the signin process" do

  before :each do
    @user = FactoryGirl.create(:user_actived)
  end

  it "signs me in" do
    visit new_user_session_path

    within(".simple_form") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end

    first('button[type="submit"]').click
    expect(page.current_path).to eq dashboard_path
  end
end
