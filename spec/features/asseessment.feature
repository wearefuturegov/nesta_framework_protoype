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
    And I should be shown the "weak skills" form
  
  Scenario: Adding Weak Skills
    Given I have started an assessment
    And I have added my strong skills
    When I access the edit assessment page
    And I choose 2 skills
    Then my assessment should have 2 weak skills
    And I should be shown the "strong attitudes" form
    
  Scenario: Adding Strong Attitudes
    Given I have started an assessment
    And I have added my weak skills
    When I access the edit assessment page
    And I choose 3 attitudes
    Then my assessment should have 3 strong attitudes
    And I should be shown the "weak attitudes" form
