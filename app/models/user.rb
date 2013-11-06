class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
  :recoverable, :rememberable, omniauth_providers: [:facebook, :twitter]

  has_many :ideas
  has_many :votes
  has_many :comments
  has_many :authentications

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  def self.find_for_oauth(auth, signed_in_resorce=nil)
    user = User.find_by_email(auth.info.email)

    unless user
      authentication = Authentication.where("provider = ? AND uid = ?", auth.provider, auth.uid).first

      if authentication
        user = authentication.user
      end
    end

    if user
      unless user.authentications.where(provider: auth.provider).present?
        Authentication.create(user: user, provider: auth.provider,
                              uid: auth.uid)
      end
    else
      user = User.create(email: auth.info.email)
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.oauth_data'] && session['devise.oauth_data']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def proper_name
    "#{last_name}, #{first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def vote_for_idea idea
    votes.where(idea: idea).first
  end
end
