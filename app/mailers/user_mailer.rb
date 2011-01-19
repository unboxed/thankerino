class UserMailer < ActionMailer::Base
  default :from => "thankerino@unboxedconsulting.com"

  def register_email(user, password)
    @user = user
    @password = password
    mail(:to => user.email, :subject => "Welcome to Thankerino!")
  end

  def thanks_notice(user)
    @user = user
    mail(:to => user.email, :subject => "New Thanks at Thankerino!")
  end

  def party
    mail(:to => 'petr.zaparka@unboxedconsulting.com', :subject => "party time")
  end

end
