class ApplicationController < ActionController::Base
  before action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_pemitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
