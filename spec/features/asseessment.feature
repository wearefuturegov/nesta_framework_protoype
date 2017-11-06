Feature: Assessment

  Background:
    Given the assessment data has been populated

  Scenario: Starting a survey
    When I access the new assessment page
    And I click next
    Then an assessment should exist
