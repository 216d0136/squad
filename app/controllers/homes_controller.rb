class HomesController < ApplicationController
  def top
  	@teams = Team.page(params[:page]).per(10).order(id: "desc")
    #@all_ranks = Team.find(Favorite.group(:team_id).order('count(team_id) desc').limit(3).pluck(:team_id))
  end

  def about
  end
end
