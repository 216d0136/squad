class FavoritesController < ApplicationController
  def create
  	@team = Team.find(params[:team_id])
    favorite = @team.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def create_comment_fav
  	favorite = Favorite.new(user_id: current_user.id, team_comment_id: params[:team_comment_id])
  	favorite.save
  	redirect_to request.referer
  end

  def destroy_comment_fav
  	favorite = current_user.favorites.find_by(team_comment_id: params[:team_comment_id])
    favorite.destroy
    redirect_to request.referer
  end

  def destroy
  	favorite = Favorite.find(params[:favorite_id])
	favorite.destroy
    redirect_to request.referer
  end


  private
  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_to teams_path
    when 1
      redirect_to team_path(@team)
    when 2
      redirect_to team_team_comments_path(@team_comment)
    end
  end
end
