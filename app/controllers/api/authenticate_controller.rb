class API::AuthenticateController < API::ApplicationController
  before_action :authenticate_user!
end
