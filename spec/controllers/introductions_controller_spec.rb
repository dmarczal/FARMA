require 'rails_helper'

RSpec.describe IntroductionsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
  end

  describe 'render the templates' do
    it "render the new" do
      get :new, lo_id: @lo
      expect(response).to render_template 'introductions/new'
    end
  end

  describe "POST create" do

    context "with valid attributes" do

      it "redirects to the #{@lo} upon save" do
        post :create, lo_id: @lo, introduction: FactoryGirl.attributes_for(:introduction)
        expect(response).to redirect_to @lo
      end

      it "create a new introduction" do
        expect{
          post :create, lo_id: @lo, introduction: FactoryGirl.attributes_for(:introduction)
        }.to change(Introduction,:count).by(1)
      end

    end

    context "with invalid attributes" do

      it "render to the new upon save" do
        post :create, lo_id: @lo, introduction: FactoryGirl.attributes_for(:invalid_introduction)
        expect(response).to render_template 'new'
      end

      it "don't shoud create a new introduction" do
        expect{
          post :create, lo_id: @lo, introduction: FactoryGirl.attributes_for(:invalid_introduction)
        }.to_not change(Introduction,:count)
      end

    end
  end

  describe 'DELETE destroy' do
    before :each do
      @introduction = FactoryGirl.create(:introduction, lo: @lo)
    end

    it "deve excluir a introdução informada" do
      expect{
        delete :destroy, lo_id: @lo, id: @introduction
      }.to change(Introduction,:count).by(-1)
    end

    it "deve redirecionar para #{@lo}" do
      delete :destroy, lo_id: @lo, id: @introduction
      expect(response).to redirect_to los_path
    end
  end

end
