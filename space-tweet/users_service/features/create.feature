Feature: Creating users

  As the SpaceTweet CEO
  I want to create user accounts
  So that people can use my application and I meet my growth goals.


  Rules:
  - users must have a name


  Scenario: creating a valid user account
    When creating a user with the attributes:
      | NAME            |
      | Jean-Luc Picard |
    Then the service contains the users:
      | NAME            |
      | Jean-Luc Picard |


  Scenario: trying to create a user account with an empty name
    When trying to create a user with the attributes:
      | NAME |
      |      |

    When sending "users.create" with the payload:
      """
      {
        name: ''
      }
      """
    Then the service replies with a "users.created" message and the payload:
      """
      {
        id: 1,
        name: 'Jean-Luc Picard'
      }
      """
    And the service contains the users:
      | NAME            |
      | Jean-Luc Picard |


  Scenario: trying to create a user account without a name field


  Scenario: trying to create a user account with an unknown field
