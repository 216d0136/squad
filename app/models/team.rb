class Team < ApplicationRecord
	belongs_to :user
	has_many :favorites
	has_many :team_comments
	attachment :image
	#validates :title, presence: true
	#validates :body ,presence: true, length: {maximum: 400}
end
