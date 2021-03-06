Factory.define :user do |u|
  u.name { Factory.next(:name) }
  u.email { Factory.next(:email) }
  u.login { Factory.next(:login) }
  u.password 'supersecret'
  u.password_confirmation 'supersecret'
end

Factory.define :group do |t|
  t.name 'group name'
end

Factory.define :thank do |t|
  t.from_user {|a| a.association(:user, :login => Factory.next(:login)) }
  t.to_user {|a| a.association(:user, :login => Factory.next(:login)) }
  t.message "#login So Long, and Thanks for All the Fish."
end

Factory.define :scoreboard do |t|
  t.name { Factory.next(:name) }
  t.user { Factory(:user) }
end

Factory.define :company do |t|
  t.name { Factory.next(:company_name) }
end

Factory.sequence :company_name do |n|
  "Comapny #{n}"
end

Factory.sequence :score_name do |n|
  "Month winner#{n}"
end

Factory.sequence :name do |n|
  "Jan Hus#{n}"
end

Factory.sequence :login do |n|
  "honza#{n}"
end

Factory.sequence :email do |n|
  "jan.hus#{n}@kostnice.com"
end
