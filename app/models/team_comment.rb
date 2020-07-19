class TeamComment < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :favorites

  #validates :comment, presence: true
  def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
  end
end
