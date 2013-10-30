class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user, :idea, :comment, presence: true
end
