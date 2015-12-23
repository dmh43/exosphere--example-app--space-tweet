Feature: Creating users

  Rules:
  - users must have a name
  - when successful, the service replies with "users.created"
    and the newly created account
  - when there is an error, the service replies with "users.not-created"
    and a message describing the error


  Scenario: creating a valid user account
    When sending the command "users.create" with the payload:
      """
      {
        name: 'Jean-Luc Picard'
      }
      """
    Then the service replies with "users.created" and the payload:
      """
      {
        id: 1,
        name: 'Jean-Luc Picard'
      }
      """
    And the service contains the user accounts:
      | NAME            |
      | Jean-Luc Picard |


  # Scenario: trying to create a user account with an empty name
  #   When sending "users.create" with the payload:
  #     """
  #     {
  #       name: ''
  #     }
  #     """
  #   Then the service replies with a "users.not-created" message and the payload:
  #     """
  #     {
  #       error: 'Name cannot be blank'
  #     }
  #     """
  #   And the service contains no users
