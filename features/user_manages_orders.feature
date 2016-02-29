Feature: User manages orders
  In order to buy band products
  As a user
  I want to manage my orders

  Background:
    Given I am a logged user

  Scenario: User creates an order
    When I create an order
    Then I should be in the final step

  Scenario: User looks for a hidden product
    When I visit shop
    Then it should be hidden
