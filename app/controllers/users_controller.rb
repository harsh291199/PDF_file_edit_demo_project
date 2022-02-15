require 'pdf_forms'

class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = User.all
    end

    def show; end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)
      first_name = @user.fname
      business_name = @user.b_name
      User.user_data(@user, first_name, business_name)

      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end

    def update
      if @user.update(user_params)
        redirect_to @user
      else
        render 'edit'
      end
    end
  
    def destroy
      @user.destroy
      redirect_to users_path
    end

    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:fname, :b_name)
    end
end
