Feature: Profanity checker
  In order to avoid displaying content of profanity, obscenity and other unwanted text
  As a content provider
  I want to be able to check if text containes profanity
	
  Scenario: Check if sentence contains profanity
    Given I call the word filter endpoint
      And I specify the response type as 'containsprofanity'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'true'

  Scenario: Check if sentence does not contains profanity
    Given I call the word filter endpoint
      And I specify the response type as 'containsprofanity'
     When I enter 'It's a great day'
     Then the output text is 'false'
