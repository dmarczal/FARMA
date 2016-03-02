require 'rails_helper'

RSpec.describe LosController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
  end

  describe "GET index" do

    it "renders the dashboard/application template " do
        sign_in @user
        get :index
        expect(response).to render_template("dashboard/application")
    end

  end

  describe "POST create" do

    context "with valid attributes" do

      it "redirects to the los_my_path upon save" do
        post :create, lo: FactoryGirl.attributes_for(:lo)
        expect(response).to redirect_to los_my_path
      end

      it "create a new lo" do
        expect{
          post :create, lo: FactoryGirl.attributes_for(:lo)
        }.to change(Lo,:count).by(1)
      end

    end

    context "with invalid attributes" do

      it "render to the new action if unsave" do
        post :create, lo: FactoryGirl.attributes_for(:invalid_lo)
        expect(response).to render_template 'new'
      end

      it "does not save the new lo" do
        expect{
          post :create, lo: FactoryGirl.attributes_for(:invalid_lo)
        }.to_not change(Lo,:count)
      end

    end

  end

end
