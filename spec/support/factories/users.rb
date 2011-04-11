# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
 f.email { Factory.next(:email) } 
 f.password "abc123"
end

Factory.define :admin, :parent => :user do |f|
 f.admin true
end

Factory.sequence :email do |n|
  "email#{n}@example.com"
end

