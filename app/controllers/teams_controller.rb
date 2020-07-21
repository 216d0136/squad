class TeamsController < ApplicationController
before_action :authenticate_user!
  def index
	@team = Team.new
    @teams = Team.all
    @all_ranks = Team.find(Favorite.group(:team_id).order('count(team_id) desc').limit(3).pluck(:team_id))
  end

  def show
    @team = Team.find(params[:id])
    @team_comments = @team.team_comments
  end

  def new
  	@team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
    screen_user(@team)
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id
    if @team.save
      redirect_to team_path(@team)
    else
      @teams = Team.all
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

    def screen_user(book)
      if @team.user.id != current_user.id
        redirect_to teams_path
      end
    end

end
