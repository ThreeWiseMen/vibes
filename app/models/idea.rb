class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :name, :leader, :description, :user, presence: true

  def vote_from_user (user)
    votes.where(user: user).first
  end

  def vote_from_user? (user)
    vote_from_user(user).present?
  end
end
