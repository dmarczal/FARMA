class WorkspaceController < ApplicationController
  layout "workspace/application"
  before_action :authenticate_user!

  def choose
  end
end
