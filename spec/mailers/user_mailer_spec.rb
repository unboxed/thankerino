require "spec_helper"

describe UserMailer do
  describe "register_email" do
    let(:mail) do
      user = mock('mock_user', {:email => 'petr.parker@thankerino.com', :name => "petr parker"})
      UserMailer.register_email(user, 'supersecret')
    end

    it "renders the headers" do
      mail.subject.should eq("Welcome to Thankerino!")
      mail.to.should eq(["petr.parker@thankerino.com"])
      mail.from.should eq(["thankerino@unboxedconsulting.com"])
    end

    it "renders the body" do
      mail.body.encoded.should include("Your account was successfully created", "your username: petr parker", "password: supersecret", "email: petr.parker@thankerino.com")
    end
  end

  describe "thanks_notice" do
    let(:mail) do
      user = mock('mock_user', {:email => 'petr.parker@thankerino.com', :name => "petr parker"})
      UserMailer.thanks_notice(user)
    end

    it "renders the headers" do
      mail.subject.should eq("New Thanks at Thankerino!")
      mail.to.should eq(["petr.parker@thankerino.com"])
      mail.from.should eq(["thankerino@unboxedconsulting.com"])
    end

    it "renders the body" do
      mail.body.encoded.should include("New Thanks at Thankerino!", "Somebody just send you thanks at Thankerino")
    end
  end

end
