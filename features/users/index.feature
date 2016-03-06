Feature: Listing users

  As a SpaceTweet admin
  I want to be able to see a list of all user accounts
  So that I can manage them.

  - go to "/users" to see a list of all users


  Scenario: users are registered
    Given the user accounts:
      | NAME            |
      | Jean-Luc Picard |
      | William Riker   |
    When viewing at the users index
    Then I see the users:
      | NAME            |
      | Jean-Luc Picard |
      | William Riker   |
