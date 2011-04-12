Feature: Manage pages
  In order to manage pages of the site
  As a user
  I want to create, edit and delete pages

  Background:
    Given I am logged in as "john@doe.com"

  Scenario: Show Pages List
    Given the following pages exist:
      | title   | content                                                                                            |
      | Title 1 | <p>Vestibulum mollis mauris enim. Morbi euismod magna ac lorem rutrum elementum.</p>               |
      | Title 2 | <p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices.</p>                           |
      | Title 3 | <p>Nam pulvinar, odio sed rhoncus suscipit, sem diam ultrices mauris, eu consequat purus.</p>      |
      | Title 4 | <p>Donec congue lacinia dui, a porttitor lectus condimentum laoreet. Nunc eu ullamcorper orci.</p> |
    And I go to the admin pages page
    Then I should see the following pages:
      | Title   | Content                                 |
      | Title 1 | Vestibulum mollis mauris enim. Morbi... |
      | Title 2 | Vestibulum ante ipsum primis in...      |
      | Title 3 | Nam pulvinar, odio sed rhoncus...       |
      | Title 4 | Donec congue lacinia dui, a...          |
  
  Scenario: Register new page
    Given I am on the new page page
    When I fill in "Title" with "title 1"
    And I fill in "Content" with "content 1"
    And I press "Create"
    Then I should see "title 1"
    And I should see "content 1"

  Scenario: Change a page
    Given a page exist with title: "Title 1", content: "<p>Nam pulvinar, odio sed rhoncus suscipit, sem diam ultrices mauris, eu consequat purus.</p>"
    When I go to the admin edit page for page "Title 1"
    When I fill in "Title" with "title 1 - new"
    And I fill in "Content" with "content 1 more"
    And I press "Update"
    Then I should see "title 1"
    And I should see "content 1"
  
  Scenario: Delete page
    Given the following pages exist:
      | title   | content                                                                                            |
      | Title 1 | <p>Vestibulum mollis mauris enim. Morbi euismod magna ac lorem rutrum elementum.</p>               |
      | Title 2 | <p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices.</p>                           |
      | Title 3 | <p>Nam pulvinar, odio sed rhoncus suscipit, sem diam ultrices mauris, eu consequat purus.</p>      |
      | Title 4 | <p>Donec congue lacinia dui, a porttitor lectus condimentum laoreet. Nunc eu ullamcorper orci.</p> |
    When I delete the 3rd page
    Then I should see the following pages:
      | Title   | Content                                 |
      | Title 1 | Vestibulum mollis mauris enim. Morbi... |
      | Title 2 | Vestibulum ante ipsum primis in...      |
      | Title 4 | Donec congue lacinia dui, a...          |
