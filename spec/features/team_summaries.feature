@javascript
Feature: Team Summaries

  Background:
    Given the assessment data has been populated

  Scenario: Showing team results
    Given my team have completed all their assessments
    When I access the team summary page
    Then I should see all my team's assessment results
    
