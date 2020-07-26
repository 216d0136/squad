class TeamsController < ApplicationController
before_action :authenticate_user!
  def index
	  @team_new = Team.new
    #@team = Team.all#(created_at: :desc)
    #@team_all = Team.all
    @team_all = Team.page(params[:page]).per(10).order(id: "desc") 
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
      @team_all = Team.all
      url = Rails.application.routes.recognize_path(request.referrer)
      pre_controller =url[:controller]
      pre_action = url[:action]
      flash[:danger] = @team_new.errors.full_messages.join(',')
      if pre_controller == "users" && pre_action == "show"
	    @user = User.find(url[:id])
	    @teams = @user.teams
        #redirect_to user_path(@user)
        redirect_to ({:action => "show", :controller => "users", :id => @user.id})
      	#render 'users/show'
      elsif pre_controller == "teams" && pre_action == "index"
      	render 'teams/index'#temas コントローラーの index アクションで使用しいているrender
        #redirect_to teams_path(@teams) 
      #elsif pre_controller == "teams" && pre_action == "show"
        #@team = Team.find_by(user_id: current_user.id)
        #@team = Team.find(params[:team][:team_id].to_i)
        #@team_comments = @team.team_comments
        #@team_comment = TeamComment.new
        #binding.pry
        #redirect_to team_path(@team) 
      	#render 'teams/show'
      else   
        redirect_to ({:action => 'new'})
      	#render 'teams/new'
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
