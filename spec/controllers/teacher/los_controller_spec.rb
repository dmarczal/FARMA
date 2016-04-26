require 'rails_helper'

RSpec.describe Workspace::LosController, type: :controller do

    before :each do
      @user = FactoryGirl.create(:user_actived)
      sign_in @user
    end

    describe "GET index" do

      it "renders the dashboard/application template " do
          get :index
          expect(response).to render_template("dashboard/application")
      end

    end

    describe "POST create" do
      context "with invalid attributes" do

        it "render to the new action if unsave" do
          post :create, lo: FactoryGirl.attributes_for(:invalid_lo)
          expect(response).to render_template :new
        end
      end
    end

    describe 'DELETE destroy' do

      before :each do
        @lo = FactoryGirl.create(:lo, user: @user)
      end

      it 'deletes the lo' do
        expect{
          delete :destroy, id: @lo
        }.to change(Lo,:count).by(-1)
      end

      it 'redirects to los_path' do
        delete :destroy, id: @lo
        expect(response).to redirect_to workspace_los_path

      end
    end
end
