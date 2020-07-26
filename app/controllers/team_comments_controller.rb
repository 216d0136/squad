class TeamCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    #@team = Team.find(params[:team_comment][:team_id])
    @team = Team.find(params[:team_id])
    @team_new = Team.new
    @team_comment = TeamComment.new
    @team.team_comments.build(comment: team_comment_params[:comment], user_id: current_user.id)
    @team_comments = @team.team_comments
   #binding.pry
    if @team.save
      flash[:notice] = "Comment was successfully created."
      redirect_to team_path(@team)
    else
    #binding.pry
      @team_comments = TeamComment.where(team_id: @team.id)
      #@team_comments = @team.team_comments
      error_message = ""
      @team.errors.full_messages.each do |message| 
        error_message << message
      end
      redirect_to ({:action => 'show', :controller => 'teams', :id => @team.id}), :notice => error_message
      #render 'teams/show'
    end
  end

  def destroy
  	@team = Team.find(params[:team_id])
  	@team_comment = @team.team_comments.find(params[:id])
    if @team_comment.user != current_user
      redirect_to request.referer
    end
    @team_comment.destroy
    redirect_to team_path(@team)
  end

  private

  def team_comment_params
    params.require(:team_comment).permit(:comment)
  end

end
