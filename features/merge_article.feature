Feature: merge articles
	As a blog administrator
	So that I can organize articles on the same subject
	I want to be able to merge two articles into one, leaving contents of both articles

Background:
	

Scenario: Non-admin should not be able merge articles
	Given the blog is set up with user "foo"
	And I am logged in as "foo"
	And I create article "Article 1" with "foo"
	And I am on the articles page
	And I follow "Article 1"
	Then I should not see "Merge Articles"

Scenario: Admin should be able to merge articles
	Given the blog is set up
    And I am logged into the admin panel
    And I create article "Article 1" with "foo"
	And I am on the articles page
	And I follow "Article 1"
    Then I should see "Merge Articles"

Scenario: Merged article should contain text of both
	Given the blog is set up
    And I am logged into the admin panel
    And I create article "Article 1" with "Lorem Ipsum"
    And I create article "Article 2" with "Quid Novi"
    And I follow "Article 1"
    And I merge "Article 1" and "Article 2"
    And I follow "Article 1"
    Then I should see "Lorem Ipsum"
    And I should see "Quid Novi"

Scenario: The article should have one author
	Given the blog is set up with user "foo"
	And I am logged in as "foo"
	And I create article "Article 2" with "Quid Novi"
	And I am on the logout page
	Given the blog is set up
    And I am logged into the admin panel
    And I create article "Article 1" with "Lorem Ipsum"
    And I follow "Article 1"
    And I merge "Article 1" and "Article 2"
    Then the author of "Article 1" should be "admin"

Scenario: The merged article should have comments from both articles
	Given the blog is set up
    And I am logged into the admin panel
    And I create article "Article 1" with "Lorem Ipsum"
    And I create article "Article 2" with "Quid Novi"
    And I am on the comments page
    And "Article 2" has comment "Fantastic!"
    And "Article 1" does not have comment "Fantastic!"
    And I follow "Article 1"
    And I merge "Article 1" and "Article 2"
    Then "Article 1" has comment "Fantastic!"

Scenario: The merged article should have the name of one of the articles merged
	Given the blog is set up
    And I am logged into the admin panel
    And I create article "Article 1" with "foo"
    And I create article "Article 2" with "bar"
    And I merge "Article 1" and "Article 2"
    And I am on the articles page
    Then I should see "Article 1"
    And I should not see "Article 2"

