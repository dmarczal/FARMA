class WorkspaceController < ApplicationController
  layout "layouts/workspace/application"
  before_action :authenticate_user!

  def choose
  end
end
