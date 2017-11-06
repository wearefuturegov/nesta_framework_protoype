@javascript
Feature: Assessment

  Background:
    Given the assessment data has been populated

  Scenario: Starting a survey
    When I access the new assessment page
    And I click next
    Then an assessment should exist

  Scenario: Adding Strong Skills
    Given I have started an assessment
    When I access the edit assessment page
    And I choose 5 skills
    Then my assessment should have 5 strong skills
    And I should be shown the weak skills form
  
