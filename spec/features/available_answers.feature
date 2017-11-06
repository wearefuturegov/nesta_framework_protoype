@javascript
Feature: Available Answers

  Background:
    Given the assessment data has been populated
    
  Scenario: Hiding strong skills
    Given I have started an assessment
    When I access the edit assessment page
    And I select the following cards:
      | Skill |
      | Building Bridges |
      | Brokering |
      | Intrapreneurship |
      | Future Acumen |
      | Tech Literacy |
    Then I should not see those cards on the next screen
    
  Scenario: Hiding strong attitudes
    Given I have started an assessment
    And I have added my weak skills
    When I access the edit assessment page
    And I select the following cards:
      | Attitude |
      | Agile |
      | Curious |
      | Reflective |
    Then I should not see those cards on the next screen
