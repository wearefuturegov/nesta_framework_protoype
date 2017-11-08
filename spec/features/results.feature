@javascript
Feature: Viewing Results

  Background:
    Given the assessment data has been populated
    
  Scenario: Showing results
    Given I have filled in my assessment
    Then I should see my results
