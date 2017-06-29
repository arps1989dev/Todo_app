class Users::RegistrationsController < Devise::RegistrationsController
  
  skip_before_action :doorkeeper_authorize!
  respond_to :json
  

  # POST /resource
  def create
    build_resource(sign_up_params)
    @user = current_resource_owner if (params[:user]).present?
  # binding.pry
    # puts "--------#{@user.inspect}---------"

    if @user.save
      render_user and return if resource.user?
      render :json=> @user, :status=>201
      return
    else
      warden.custom_failure!
      render :json=> @user.errors, :status=>422
    end
  end


  private

  def render_user
    render json: resource, serializer: Users::UserSerializer, status: 200
  end

end
