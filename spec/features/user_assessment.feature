@javascript
Feature: User Assessments

  Background:
    Given the assessment data has been populated

  Scenario: User has email address prepopulated
    Given I create an assessment from the user link
    And I fill out the assessment
    Then I should see my email address on the user form

  Scenario: Assessment form updates user details
    Given I have filled out an assessment from the user link
    And I enter my details
    Then my assessment should have the correct contact details
  
  Scenario: Can see a link to the team comparison page
    Given I have filled out an assessment from the user link
    And I enter my details
    Then I should see a link to my team's comparison page
