class TeamController < ApplicationController
  def index
    @active_developers = Admin::Developer.where(active: true).order(active: :desc).order(:start_on_project)
    @inavtive_developers = Admin::Developer.where(active: false).order(active: :desc).order(:start_on_project)
  end
end
