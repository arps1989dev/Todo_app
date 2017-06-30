class ApplicationController < ActionController::API
  before_action :doorkeeper_authorize!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Response
  include ExceptionHandler

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "You are not authorized." } }
  end

  # before_action :authorize_request
  # attr_reader :current_user

  private

  # def authorize_request
  #   @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  # end

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)

    if current_resource_owner.present?
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    else
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
  end

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
  
end
