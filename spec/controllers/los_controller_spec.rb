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

      it "redirects to the los_path upon save" do
        post :create, lo: FactoryGirl.attributes_for(:lo)
        expect(response).to redirect_to los_path
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
      expect(response).to redirect_to los_path
      
    end

  end

  describe "PUT update" do

    before :each do
      @lo = FactoryGirl.create(:lo, name: "name test", description: "description test", user: @user)
    end

    context 'valid attributes' do

      it "located the requested @lo" do
        put :update, id: @lo, lo: FactoryGirl.attributes_for(:lo)
        assigns(:lo).should eq(@lo)
      end

      it "changes @lo's attributes" do
        put :update, id: @lo,
          lo: FactoryGirl.attributes_for(:lo, name: "name test 2", description: "description test 2")
        @lo.reload
        @lo.name.should eq("name test 2")
        @lo.description.should eq("description test 2")
      end

      it "redirects to los_path when lo is updated" do
        put :update, id: @lo, lo: FactoryGirl.attributes_for(:lo)
        response.should redirect_to los_path
      end

    end

    context "invalid attributes" do
      it "locates the requested @lo" do
        put :update, id: @lo, lo: FactoryGirl.attributes_for(:invalid_lo)
        assigns(:lo).should eq(@lo)
      end

      it "does not change @lo's attributes" do
        put :update, id: @lo,
          lo: FactoryGirl.attributes_for(:lo, name: "name test 2", description: nil)
        @lo.reload
        @lo.name.should_not eq("name test 2")
        @lo.description.should eq("description test")
      end

      it "re-renders the edit method" do
        put :update, id: @lo, lo: FactoryGirl.attributes_for(:invalid_lo)
        response.should render_template :edit
      end
    end

  end

end
