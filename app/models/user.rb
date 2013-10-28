class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable

  has_many :ideas
  has_many :votes

  validates :first_name, :last_name, :about_me, presence: true

  def proper_name
    "#{last_name}, #{first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
