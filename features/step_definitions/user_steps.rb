Given /^I am logged in as admin$/ do
  email    = 'admin@admin.com'
  password = 'secretpass'

  steps %Q{
    Given a user exist with email: "#{email}", password: "#{password}", admin: true
    And I go to login
    And I fill in "user_email" with "#{email}"
    And I fill in "user_password" with "#{password}"
    And I press "Sign in"
 }
end

Given /^I am not logged in$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit admin_users_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.diff!(tableish('table tr', 'td,th'))
end

