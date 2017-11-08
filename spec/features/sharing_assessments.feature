@javascript
Feature: Sharing Assessments

  Scenario: Creating a new team
    Given I have a completed assessment
    When I share the assessment with my team members
    Then a team should be created with those team members
    
