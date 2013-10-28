class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :idea, :user, :kind, presence: true
end
