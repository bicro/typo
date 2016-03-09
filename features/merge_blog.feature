Feature: Merge Blogs
  As a blog administrator
  In order to curb redundant articles
  I want to be able to merge articles

  Background:
    Given the blog is set up
    And the following articles exist:
      | allow_comments | allow_pings | author | body | guid | id | permalink | post_type | published | published_at | settings | state | text_filter_id | title | type | user_id |
      | true | true | "Eric" | "This is a body" | "1bf3e2ca-ed7b-4562-8a4a-8ce8438822c8"| 1 | "eric-article" | "read" | true | "2012-06-09 21:51:55 UTC" | {} | "published" | 5 | "A" | "article" | 2 |
      | true | true | "Joe" | "This is Joe's article" | "1bf3e2ca-ed7b-4562-8a4a-8ce8438822c9" | 2 | "joe-article" | "read" | true | "2012-06-09 21:51:35 UTC" | {} | "published" | 5 | "B" | "article" | 1 |
    And I am on article "A"

  Scenario: A non-admin cannot merge articles
    Given I am not an admin
    Then I should not see the merge option on articles
  
  Scenario: Merged articles should contain the text of both previous articles.
    Given I am an admin
    When I fill in "Article ID" with "2"
    Then I click "Merge"
    Then I should see the text of both "A" and "B"
    
  Scenario: Merged article should have one author (either one of the authors of the original article).
    Given I am an admin
    When I fill in "Article ID" with "2"
    Then I click "Merge"
    Then I should see the new author as "A" or "B"
  
  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
    Given I am an admin
    When I fill in "Article ID" with "2"
    Then I click "Merge"
    Then I should see all the comments from "A" and "B" on the merged article
  
  Scenario: The title of the new article should be the title from either one of the merged articles.
    Given I am an admin
    When I fill in "Article ID" with "2"
    Then I click "Merge"
    Then I should see the merged article be titled "A" or "B"