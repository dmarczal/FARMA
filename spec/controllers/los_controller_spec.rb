require 'rails_helper'

RSpec.describe LosController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user_actived)
  end

  it "renders the index template los index" do
      sign_in @user
      get :index
      expect(response).to render_template("los/index")
  end
end
