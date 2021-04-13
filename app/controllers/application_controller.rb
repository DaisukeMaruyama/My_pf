class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_genre_all
  before_action :set_host

  protected

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  def get_genre_all
    @genres = Genre.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def after_sign_in_path_for(resource)
    if resource.instance_of?(User)
      root_path
    elsif resource.instance_of?(Admin)
      admin_items_path
    else
      items_path
    end
  end

  def after_sign_up_path_for(resource)
    if resource.instance_of?(User)
      user_path(current_user)
    elsif resource.instance_of?(Admin)
      admin_orders_path
    else
      items_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      root_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end

end
