class RegistrationsController < ApplicationController
  skip_before_action :authenticate_request,only: :create
  # skip_before_action :verify_authenticity_token, only: :create
    def index
        @users = User.all
        render json: @users, status: :ok
      end
    
      # GET /users/{username}
      def show
        render json: @user, status: :ok
      end
    
      # POST /users
      def create
        @user = User.create!(user_params)
        command = AuthenticateUser.new(@user.email,@user.password).call
      
        if command.success?
          render json: { auth_token: command.result }
          session[:user_id]=@user.id
         
          # flash[:info] = "Please check your email to activate your account."
          # redirect_to root_url
        else
          render json: { error: command.errors }, status: :unauthorized
        end
       
      end
    
      # PUT /users/{username}
      def update
        unless @user.update(user_params)
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    
      # DELETE /users/{username}
      def destroy
        @user.destroy
      end
    

    private

    def user_params
      params.permit(:name,:email,:password,:password_confirmation)

    end

end
