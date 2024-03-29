Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

  Scenario: Before init
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    Then the file "config.rb" should contain:
    """
    activate :presentation
    """
    And the file "Gemfile" should contain:
    """
    middleman-presentation
    """
    And a file named "bower.json" should exist
    And a file named ".bowerrc" should exist
    And a file named ".gitignore" should exist
    And a file named "source/layout.erb" should exist
    And a file named "source/slides/00.html.erb" should exist
    And a file named "source/index.html.erb" should exist
    And a file named "source/stylesheets/application.scss" should exist
    And a file named "source/javascripts/application.js" should exist
    And a file named "script/start" should exist
    And a file named "Rakefile" should exist
    And a directory named "source/images" should exist
    And a directory named "vendor/assets/components" should exist
    And the file "data/metadata.yml" should contain:
    """
    project_id:
    """

  Scenario: Existing configuration file
    Given a mocked home directory
    And  a file named "~/.config/middleman/presentation/presentations.yaml" with:
    """
    author: TestUser
    company: MyCompany
    email_address: test_user@example.com
    homepage: http://example.com
    language: en
    speaker: TestUser
    """
    And a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation"`
    Then the file "data/metadata.yml" should contain:
    """
    author: TestUser
    """
    Then the file "data/metadata.yml" should contain:
    """
    company: MyCompany
    """
    Then the file "data/metadata.yml" should contain:
    """
    email_address: test_user@example.com
    """
    Then the file "data/metadata.yml" should contain:
    """
    homepage: http://example.com
    """
    Then the file "data/metadata.yml" should contain:
    """
    speaker: TestUser
    """

  Scenario: German umlauts, French accents and special chars are not a problem for project id
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "üöà~?§$%&/()=#!"`
    And the file "data/metadata.yml" should contain:
    """
    project_id: uoa
    """

  Scenario: Use lang from environment as language in slides
    Given a fixture app "presentation-before_init-app"
    And I set the environment variables to:
      | variable | value      |
      | LANG     | de_DE.UTF-8|
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use lang from command line as language in slides
    Given a fixture app "presentation-before_init-app"
    And I set the environment variables to:
      | variable | value      |
      | LANG     | de_DE.UTF-8|
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344 --language en`
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Ignore case of lang value
    Given a fixture app "presentation-before_init-app"
    And I set the environment variables to:
      | variable | value      |
      | LANG     | de_de.utf-8|
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    When I successfully run `env`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Fragen
    """

  Scenario: Use englisch language in slides based if garbabe in environment variable
    Given a fixture app "presentation-before_init-app"
    And I set the environment variables to:
      | variable | value |
      | LANG     | asdf  |
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """

  Scenario: Use englisch language in slides if given garbabe on command line
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344 --language adsfasdfn`
    And the file "source/slides/999980.html.erb" should contain:
    """
    Questions
    """
