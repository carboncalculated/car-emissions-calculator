@javascript
Feature: Creating a Car Calculator  
  Scenario: Calculating a Car Journey
    Given I am an anonymous user
    And I am on the new car calculator page
    
    When I select manufacture: porsche
    And I select fuel_type: petrol
    And I select model: whatever
    And I select car: 911 40th Anniversary Edition - 3596cc - M6 - 2004 - May onwards
    And I enter a distance of 20
    And I press "Calculate"
    
    Then I should see "Your car journey was calculated to have produced..."
    And I should see "1.702557"
    
    
  

  
