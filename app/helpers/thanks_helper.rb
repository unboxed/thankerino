module ThanksHelper
  def target_user(thank)
    (thank.to_user.name.blank?)? thank.to_user.login : thank.to_user.name
  end
end
