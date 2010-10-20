module ApplicationHelper
  def active_item?(controller, action)
    return 'active' if controller == params[:controller] && action == params[:action]
    'inactive'
  end
end
