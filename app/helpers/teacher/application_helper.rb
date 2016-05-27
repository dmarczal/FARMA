module Teacher::ApplicationHelper

  def active_class current_controller
    controller.controller_name == current_controller ? 'class=active' : nil
  end

  def active_class_for_links controllers
    current_controller = nil

    controllers.each do |controller|
      if active_class controller
        current_controller = 'class=active'
      end
    end

    current_controller
  end
end
