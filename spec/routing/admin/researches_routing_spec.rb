require "rails_helper"

RSpec.describe Admin::ResearchesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/researches").to route_to("admin/researches#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/researches/new").to route_to("admin/researches#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/researches/1").to route_to("admin/researches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/researches/1/edit").to route_to("admin/researches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/researches").to route_to("admin/researches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/researches/1").to route_to("admin/researches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/researches/1").to route_to("admin/researches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/researches/1").to route_to("admin/researches#destroy", :id => "1")
    end
  end
end
