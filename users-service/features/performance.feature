Feature: Performance

  As the devops person
  I want the user service to exhibit consistent high performance
  So that my production system performs well in predictable ways.


  Rules:
  - single requests must be processed within 2 ms
  - the server must be able to process 1000 parallel requests within 5 ms each


  @todo
  Scenario: single request performance
    When creating a user account
    Then the request is processed in less than 2 milliseconds


  @todo
  Scenario: parallel request performance
    When creating 1000 user accounts in parallel
    Then each request is processed in less than 5 milliseconds
