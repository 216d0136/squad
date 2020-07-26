class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :team, optional:true
  belongs_to :team_comment, optional:true

end
