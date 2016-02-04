Feature: Listing all users

  Rules:
  - returns all users currently stored


  Background:
    Given an ExoComm server running at port 4100
    And an instance of this service running at port 4000


  Scenario: no users exist in the database
    When sending the command "users.list"
    Then the service replies with "users.listed" and the payload:
      """
      count: 0
      users: []
      """


  Scenario: users exist in the database
    Given the service contains the users:
      | NAME            |
      | Jean-Luc Picard |
    When sending the command "users.list"
    Then the service replies with "users.listed" and the payload:
      """
      count: 1
      users: [
        * name: 'Jean-Luc Picard'
          id: /\d+/
      ]
      """
