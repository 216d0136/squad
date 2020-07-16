class TeamCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @team = Team.find(params[:team_id])
    @team_new = Team.new
    @team_comment = @team.team_comments.new(team_comment_params)
    @team_comment.user_id = current_user.id
    if @team_comment.save
      flash[:success] = "Comment was successfully created."
    else
      @team_comments = TeamComment.where(id: @team)
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
