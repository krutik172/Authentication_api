class SessionsController < ApplicationController
  skip_before_action :authenticate_request
    include CurrentUserConcern

    def authenticate
      @user = User.find_by_email(params[:email])
      command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
            
            session[:user_id]=@user.id
            render json: { auth_token: command.result } ,logged_in: true
           
        else
            render json: { error: command.errors }, status: :unauthorized
         end

      end

    def logged_in
      
        if @current_user
            render json: @current_user , status: :created 
        else
            render json: {
                logged_in: false
            }
        end
 
    end

    def logout
        reset_session
        render json: { status: 200, logged_out: true }
    end

    private

    def users_params
      params.permit(:name,:email,:password,:password_confirmation)

    end
end