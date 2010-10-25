class UserMailer < ActionMailer::Base
  default :from => "petr.zaparka@unboxedconsulting.com"
  
  def register_email(user, password)
    @user = user
    @password = password
    mail(:to => user.email,
         :subject => "Welcome to Thankerino!")
  end
end
