@javascript
Feature: Back Button
  
  Background:
    Given the assessment data has been populated

  Scenario: Going back to the strong skills form
    Given I have started an assessment
    When I access the edit assessment page
    And I choose 5 skills
    And I click the back button
    And I should be shown the "strong skills" form
    And my skills should be selected
