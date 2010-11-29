module UsersHelper
  def generate_password(mail)
    password = []
    6.times{password << [0..rand(mail.size)]}
    a = password.to_s[0..5].insert(3,rand(100).to_s)
    a.to_s.gsub("'",rand(10).to_s).gsub('"',rand(10).to_s)
  end
end
