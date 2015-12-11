class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :movies, through: :intentions

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      p "Here's the auth printout Here's the auth printout Here's the auth printout Here's the auth printout Here's the auth printout Here's the auth printout Here's the auth printout :"
      p auth
      user.email = auth.info.email
      user.image = auth.info.image
      p "Here are the friends"
      p auth.friends
      p "Here's the summary"
      p auth.summary
      user.friends = auth.friends
      user.password = Devise.friendly_token[0,20]
    end
  end


end
