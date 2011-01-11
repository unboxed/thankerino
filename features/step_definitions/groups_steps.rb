Then /^I should see the groups:$/ do |grouptable|
  grouptable.diff!(tableish('table tr', 'td,th'))
end
