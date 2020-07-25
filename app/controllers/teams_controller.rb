class TeamsController < ApplicationController
before_action :authenticate_user!
  def index
	  @team_new = Team.new
    #@team = Team.all#(created_at: :desc)
    @team_all = Team.all
    #@teams = Team.page(params[:page]).per(10).order(id: "desc") 
  end

  def show
    @team = Team.find(params[:id])
    @team_new = Team.new
    @team_comments = @team.team_comments
    @team_comment = TeamComment.new
  end

  def new
  	@team_new = Team.new
  end

  def edit
    @team = Team.find(params[:id])
    screen_user(@team)
  end

  def create
    @team_new = Team.new(team_params)
    @team_new.user_id = current_user.id
    if @team_new.save
      redirect_to team_path(@team_new)
    else
      render 'teams/new'
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

    def screen_user(team)
      if @team.user.id != current_user.id
        redirect_to teams_path
      end
    end

end
