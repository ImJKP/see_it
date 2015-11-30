class UserMailer < ApplicationMailer
  default from: "Let's See It <jordankphillips@gmail.com>"

#  def say_hello(name)
#    @name = name
#    mail(to: "test@test.com", subject: "Hello there!")
#  end
    
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to See It!")
  end

end
