Feature: Recording calls

  As a developer testing my micro-service architecture
  I want to be able to record HTTP calls sent by my services under test
  So that I can verify their behavior from the outside.

  Rules:
  - the library is told to listen on a given port
  - every call to that port is recorded
  - the library allows to retrieve the recorded calls programmatically


  Scenario: recording GET requests
    Given a http-listener instance listening on port 7777
    When sending a GET request to http://localhost:7777/one
    And sending a GET request to http://localhost:7777/two
    Then the recorded calls are:
      """
      [
        {
          method: 'GET',
          url: '/one'
        },
        {
          method: 'GET',
          url: '/two'
        }
      ]
      """
