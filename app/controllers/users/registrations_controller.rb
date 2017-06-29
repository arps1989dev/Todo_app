class Users::RegistrationsController < Devise::RegistrationsController
  
  skip_before_action :doorkeeper_authorize!
  respond_to :json
  

  # POST /resource
  # def create
  #   build_resource(sign_up_params)
    
  #   if @user.save
  #     render :json=> @user, :status=>201
  #     return
  #   else
  #     warden.custom_failure!
  #     render :json=> @user.errors, :status=>422
  #   end
  # end

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
        else
          expire_data_after_sign_in!
        end
        render json: resource, status: :ok
      else
        render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end

  end


  protected

  def authenticate_scope!
    # send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

end
