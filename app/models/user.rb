class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable

  has_many :ideas
  has_many :votes
  has_many :comments

  validates :first_name, :last_name, :about_me, presence: true

  def proper_name
    "#{last_name}, #{first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def vote_for_idea idea
    Vote.where(idea: idea).first
  end
end
