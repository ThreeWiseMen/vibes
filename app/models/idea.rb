class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  has_many :comments

  validates :name, :leader, :description, :user, presence: true

  def vote_from_user (user)
    votes.where(user: user).first
  end

  def vote_from_user? (user)
    vote_from_user(user).present?
  end

  def upvotes
    votes.where(kind: 1)
  end

  def downvotes
    votes.where(kind: -1)
  end

  def upvote_count
    upvotes.count
  end

  def downvote_count
    downvotes.count
  end

  def score
    votes.sum(:kind)
  end
end
