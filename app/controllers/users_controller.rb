class UsersController < ApplicationController
include UserHelper
    def new
        users = User.new
    end
      
      def create
        user = User.find_by(email: params[:users][:email].downcase)
      if user
          flash.now[:danger] = 'User with this email already exists.'
          render('new')
      
      else
          flash.now[:success] = 'New account created'
          user = { name: params[:users][:name], email: params[:users][:email].downcase, password: params[:users][:password] }
          sign_up(user)
          render('new')
        end
      end
      
     private
      
      def user_params
        params.require(:user).permit(:username, :email, :password)
      end
end
