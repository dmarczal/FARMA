class API::ApplicationController < ActionController::API
  # before_action :authenticate_user!

  include APIResponses
  include ActionController::Cookies

  before_action :find_exercise

  protected

  def find_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end
end
