require 'rails_helper'

RSpec.describe "Admin::Researches", type: :request do
  describe "GET /admin_researches" do
    it "works! (now write some real specs)" do
      get admin_researches_path
      expect(response).to have_http_status(200)
    end
  end
end
