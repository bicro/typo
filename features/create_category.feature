Feature:Category

  Background:
    Given the blog is set up
  Scenario: Edit a category page
    Given I am an admin
    Then I follow "Categories"
    Then I follow "Edit"
    And I should see "Categories" 
    
  Scenario: Create a category page
    Given I am an admin
    Then I follow "Categories"
    And I should see "Categories"