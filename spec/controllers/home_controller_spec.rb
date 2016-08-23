require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "render_template home/application" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template "layouts/home/application"
    end
  end

end
