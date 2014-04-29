Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

  @wip
  Scenario: Before init
    Given a fixture app "presentation-before_init-app"
    When I successfully run `middleman presentation`
    Then the file "config.rb" should contain:
    """
    activate :presentation
    """