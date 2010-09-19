# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
User.create({:name => 'Jan', :login => 'jan', :email => 'jan@jan.com', :password => '12jan34', :password_confirmation => '12jan34'})
User.create({:name => 'Tom', :login => 'tom', :email => 'tom@tom.com', :password => '12tom34', :password_confirmation => '12tom34'})
User.create({:name => 'Jane', :login => 'jane', :email => 'jane@jane.com', :password => '12jane34', :password_confirmation => '12jane34'})
User.create({:name => 'David', :login => 'david', :email => 'david@david.com', :password => '12david34', :password_confirmation => '12david34'})
