class UsersController < ApplicationController
  #before_action :authenticate_user!
  #before_action :screen_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end



  private
    def user_params
       params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
