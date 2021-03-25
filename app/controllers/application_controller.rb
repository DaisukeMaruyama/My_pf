class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_genre_all

  protected
  
  def get_genre_all
    @genres = Genre.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :postal_code, :phone_number])
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
      customer_path(current_user)
    elsif resource.instance_of?(Admin)
      admin_orders_path
    else
      items_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :User
      new_customer_session_path
    elsif resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end
  
end
