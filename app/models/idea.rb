class Idea < ActiveRecord::Base
  belongs_to :user

  validates :name, :leader, :description, :user, presence: true
end
