class TeamsController < ApplicationController
before_action :authenticate_user!
  def index
	  @team = Team.new
    #@team = Team.all#(created_at: :desc)
    @teams = Team.all
    #@teams = Team.page(params[:page]).per(10).order(id: "desc") 
  end

  def show
    @team = Team.find(params[:id])
    @teams = Team.new
    @team_comments = @team.team_comments
    @team_comment = TeamComment.new
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
      url = Rails.application.routes.recognize_path(request.referrer)
      pre_controller =url[:controller]
      pre_action = url[:action]
      
      if pre_controller == "users" && pre_action == "show"
	    @user = User.find(url[:id])
	    @teams = @user.teams    	
      	render 'users/show'
      elsif pre_controller == "teams" && pre_action == "index"
      	render 'teams/index'#temas コントローラーの index アクションで使用しいているrender
      elsif pre_controller == "teams" && pre_action == "show"
        @team = Team.find(params[:team][:team_id])
        @team_comments = @team.team_comments
        @team_comment = TeamComment.new
      	render 'teams/show'
      else
      	render 'teams/new'
      end
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
