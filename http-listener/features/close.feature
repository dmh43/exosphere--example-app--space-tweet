Feature: Running different instances one at a time on the same port

  As a developer using this library for testing
  I want to be able to shut down existing endpoints
  So that I can re-use the same network port in different tests.

  Rules:
  - call `close()` on your instance to make it stop listening
  - after that, you can create a new instance on the same port
  - the two instances don't share any data


  Scenario: closing an active listener
    Given a http-listener instance listening on port 7777
    And a GET request to http://localhost:7777/first
    When closing this instance
    Then requests to http://localhost:7777 are no longer possible
    When setting up another http-listener instance listening on port 7777
    And a GET request to http://localhost:7777/second
    Then the recorded calls are:
      """
      [
        {
          method: 'GET',
          url: '/second'
        }
      ]
      """
