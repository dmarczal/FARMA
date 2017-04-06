class RegistrationsController < Devise::RegistrationsController

  protected
  def after_update_path_for(resource)
    choose_workspace_path
  end

  private
  def layout_by_resource
    last_module = /[a-zA-Z0-9]\/(.*)/.match(request.referer)
    last_module = last_module.nil? ? '' : last_module[1]

    if action_name == 'edit'
      "#{last_module}/application"
    end
  end
end
