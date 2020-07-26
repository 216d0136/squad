class Team < ApplicationRecord
	belongs_to :user
	has_many :favorites
	has_many :team_comments
	attachment :image
	validates :image, presence: true
	validates :name, presence: true
	validates :body ,presence: true, length: {maximum: 400}
	def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
end
