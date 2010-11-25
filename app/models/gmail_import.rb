module GmailImport

  def self.import!(file)
    require 'fastercsv'
    require 'iconv'

    file_content = file.read

    # content = Iconv.iconv('UTF-8', 'WINDOWS-1252', file_content)
    raw_user_info = []
    FasterCSV.parse(file_content) do |row|
      raw_user_info << row
    end

    raw_user_info.delete_at(0)

    raw_user_info.each do |user_info|
      next if user_info.blank?
      password = generate_password(user_info.last)
      user = User.new(
        :name => user_info.first,
        :email => user_info.last,
        :password => password
      )

      user.save!
      UserMailer.register_email(user, password).deliver
    end
  end

  def self.generate_password(mail)
    password = []
    6.times{password << [0..rand(mail.size)]}
    a = password.to_s[0..5].insert(3,rand(100).to_s)
    a.to_s.gsub("'",rand(10).to_s).gsub('"',rand(10).to_s)
  end

end