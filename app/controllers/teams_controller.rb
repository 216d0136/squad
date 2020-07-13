class TeamsController < ApplicationController
def index
    @teams = Team.all
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
  end
  def edit
    @team = Team.find(params[:id])
    #screen_user(@team)
  end

  def create
    @team = Team.new(team_params)
    #binding.pry
     @team.user_id = current_user.id
    if @team.save
      redirect_to team_path(@team)
    else
      @team = Team.all
      render 'index'
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to @team
    else
      render 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_path
  end

  private
    def team_params
      params.require(:team).permit(:name, :body, :image)
    end	

end
