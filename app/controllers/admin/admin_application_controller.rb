class Admin::AdminApplicationController < ::ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_admin!

  layout 'layouts/admin/application'
end
