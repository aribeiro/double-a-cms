Feature: Manage users
  In order to manage user accounts
  As and admin user
  I want to create, edit and delete users
  
  Background:
    Given I am logged in as admin

  Scenario: Show User List
    Given the following users exist:
      | email             | password |
      | david@example.com | 123456   |
      | mark@example.com  | 123456   |
      | chris@example.com | 123456   |
      | pill@example.com  | 123456   |
    And I go to the admin users page
    Then I should see the following users:
      | E-mail            | Type  |
      | admin@admin.com   | Admin |
      | david@example.com | Staff |
      | mark@example.com  | Staff |
      | chris@example.com | Staff |
      | pill@example.com  | Staff |

  Scenario: Register new user
    Given I am on the admin new user page
    And I fill in "Email" with "david@example.com"
    And I fill in "Password" with "secretpass"
    And I check "Admin"
    And I press "Create"
    Then I should be on the admin users page
    And I should see "david@example.com"
    And I should see "Admin"
  
  Scenario: Change a user
    Given a user exist with email: "john@doe.com", password: "123456"
    When I go to the admin edit page for user "john@doe.com"
    And I fill in "Email" with "david@example.com"
    And I fill in "Password" with "newsecretpass"
    And I press "Update"
    Then I should be on the admin users page
    And I should see "david@example.com"
    And I should not see "john@doe.com"

  Scenario: Delete user
    Given the following users exist:
      | email             | password |
      | david@example.com | 123456   |
      | mark@example.com  | 123456   |
      | chris@example.com | 123456   |
      | pill@example.com  | 123456   |
    When I delete the 3rd user
    Then I should see the following users:
      | E-mail            | Type  |
      | admin@admin.com   | Admin |
      | david@example.com | Staff |
      | chris@example.com | Staff |
      | pill@example.com  | Staff |
