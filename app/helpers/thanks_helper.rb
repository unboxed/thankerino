module ThanksHelper
  def target_user(thank)
    (thank.to_user.name.blank?)? thank.to_user.login : thank.to_user.name
  end
  
  def thanks_for_user(user)
    Thank.where(:to_user => user)
  end
end
