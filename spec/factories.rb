Factory.define :user do |u|
  u.name 'Jan Hus'
  u.login { Factory.next(:login) }
  u.email { Factory.next(:email) }
  u.password 'supersecret'
  u.password_confirmation 'supersecret'
end

Factory.define :thank do |t|
  t.from_user {|a| a.association(:user, :login => 'login2') }
  t.to_user {|a| a.association(:user, :login => 'login') }
  t.message "#login So Long, and Thanks for All the Fish."
end

Factory.sequence :login do |n|
  "honza#{n}"
end

Factory.sequence :email do |n|
  "jan.hus#{n}@kostnice.com"
end
