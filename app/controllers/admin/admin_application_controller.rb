class Admin::AdminApplicationController < ::ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  before_action :area=

  layout 'layouts/admin/application'

  protected

  def area=
    cookies[:farma_area] = "admin"
  end

  def strip_params(_params)
    _params.each do |k, v|
      v.strip!
    end
  end
end
