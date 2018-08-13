class TeamController < ApplicationController
  def index
    @active_developers = Admin::Developer.actives
    @inavtive_developers = Admin::Developer.inactives
  end
end
