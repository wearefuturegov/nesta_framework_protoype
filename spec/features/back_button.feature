@javascript
Feature: Back Button

  Scenario: Going back to the strong skills form
    Given I have started an assessment
    And I have added my strong skills
    When I access the edit assessment page
    And I click the back button
    And I should be shown the "strong skills" form
