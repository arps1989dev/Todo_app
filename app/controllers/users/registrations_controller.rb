class Users::RegistrationsController < Devise::RegistrationsController

  # prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
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

  # PUT /resource
  def update
    # resource.skip_reconfirmation! if resource.customer?
    
    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      # render_customer_data and return if resource.customer?
      # render_worker_date and return if resource.worker? || resource.sub_admin?
      render json: resource, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end


  protected

  def authenticate_scope!
    # send(:"authenticate_#{resource_name}!", force: true)
     self.resource = User.find(params[:id])
  end

  # def account_update_params
  #   devise_parameter_sanitizer.sanitize(:account_update)
  # end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
