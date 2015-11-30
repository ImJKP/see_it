class UsersController < ApplicationController

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

end
