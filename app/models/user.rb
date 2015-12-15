class User < ActiveRecord::Base
  serialize :friends
  has_many :movies, through: :intentions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def get_friends
    request = Typhoeus::Request.new(
    URI.escape("https://graph.facebook.com/v2.5/me/friends"),
    method: :get,
    params: { access_token: self.facebook_token },
    )
    request.run
    response = JSON.parse(request.response.body)
    my_friends = []
    response["data"].to_a.each do |friend|
      my_friends << friend["id"].delete("^0-9")
    end
      self.update_attribute(:friends, my_friends)
  end

  def get_user_attributes
  request = Typhoeus::Request.new(
    URI.escape("https://graph.facebook.com/v2.5/me/"),
    method: :get,
    params: { access_token: self.facebook_token, fields: "first_name,last_name" },
    )
    request.run
    response = JSON.parse(request.response.body)
    self.update_attributes(:first_name => response["first_name"], :last_name => response["last_name"])
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
      user.facebook_token = auth["credentials"]["token"]
      user.password = Devise.friendly_token[0,20]
    end
  end

  def full_name
    [first_name, last_name].join(" ")
  end

end
