class UsersController < ApplicationController
  before_action :authenticate_user!
  #before_action :screen_user, only: [:edit, :update]
 def show
    @user = User.find(params[:id])
    @teams = @user.teams
    @team = Team.new
  end

  def index
    @users = User.all
    @team = Team.new
  end

  def edit
    @user = User.find(params[:id])
  end

  private
    def user_params
       params.require(:user).permit(:name, :introduction, :profile_image_id)
    end
end
