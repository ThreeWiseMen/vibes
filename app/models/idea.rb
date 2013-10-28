class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :name, :leader, :description, :user, presence: true
end
