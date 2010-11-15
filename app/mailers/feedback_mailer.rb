class FeedbackMailer < ActionMailer::Base
  default :from => "thankerino@unboxedconsulting.com"

  def feedback_mail(feedback)
    @sent_on     = Time.now
    @body[:feedback] = feedback
    mail(:to => "thankerino@unboxedconsulting.com", :subject => "Feedback mail")
  end
end
