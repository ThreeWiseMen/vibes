class Authentication < ActiveRecord::Base
  belongs_to :user

  validate :user, :provider, :uid, presence: true
end
