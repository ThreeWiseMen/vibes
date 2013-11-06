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

  def score
    sum = 0
    votes.each { |v| sum += v.kind }
    "#{sum} / #{votes.count}"
  end
end
