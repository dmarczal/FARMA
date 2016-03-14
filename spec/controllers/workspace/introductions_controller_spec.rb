require 'rails_helper'

RSpec.describe Workspace::IntroductionsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user_actived)
    sign_in @user
    @lo = FactoryGirl.create(:lo, user: @user)
  end

  describe "POST create" do

    context "with valid attributes" do

      it "redirects to the #{@lo} upon save" do
        post :create, lo_id: @lo, introduction: FactoryGirl.attributes_for(:introduction)
        expect(response).to redirect_to [:workspace, @lo]
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
        expect(response).to render_template :new
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

    it "should be delete informed introduction" do
      expect{
        delete :destroy, lo_id: @lo, id: @introduction
      }.to change(Introduction,:count).by(-1)
    end

    it "should be redirect to #{@lo}" do
      delete :destroy, lo_id: @lo, id: @introduction
      expect(response).to redirect_to [:workspace, @lo]
    end
  end

  describe "PUT update" do
    before :each do
      @introduction = FactoryGirl.create(:introduction,title: 'title', content: 'content', lo: @lo)
    end

    context 'valid attributes' do

      it 'located the requested @introduction' do
        put :update, lo_id: @lo, id: @introduction, introduction: FactoryGirl.attributes_for(:introduction)
        assigns(:introduction).should eq @introduction
      end

      it "should be redirect to #{@lo}" do
        put :update, lo_id: @lo, id: @introduction, introduction: FactoryGirl.attributes_for(:introduction)
        expect(response).to redirect_to [:workspace, @lo]
      end

      it "should be updated the #{@introduction} attributes" do
        put :update, lo_id: @lo, id: @introduction, introduction: FactoryGirl.attributes_for(:introduction, title: "test", content: "test")
        @introduction.reload
        @introduction.title.should eq "test"
        @introduction.content.should eq "test"
      end

    end

    context 'invalid attributes' do

      it 'should be render the action new' do
          put :update, lo_id: @lo, id: @introduction, introduction: FactoryGirl.attributes_for(:invalid_introduction)
          expect(response).to render_template :edit
      end

      it "should not updated the #{@introduction} attributes" do
        put :update, lo_id: @lo, id: @introduction, introduction: FactoryGirl.attributes_for(:introduction, title: "test", content: nil)
        @introduction.reload
        @introduction.title.should eq "title"
        @introduction.content.should eq "content"
      end

    end

  end
end
