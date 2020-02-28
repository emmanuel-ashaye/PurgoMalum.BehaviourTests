Feature: WordFilter
In order to avoid displaying content of profanity, obscenity and other unwanted text
As a content provider
I want to be able to filter such content

  Scenario: Check default profain word replacement
    Given I call the word filter endpoint
      And I specify the response type as 'xml'
     When I enter 'shit'
     Then the output text is '****'

  Scenario: Check profain word is replaced in a sentence
    Given I call the word filter endpoint
      And I specify the response type as 'json'
     When I enter 'It's been a bit shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit **** show, no thanks to that *****'

  Scenario: Check sentance unchanged 
    Given I call the word filter endpoint
      And I specify the response type as 'json'
     When I enter 'The show has been a bit of a success, thanks to the team'
     Then the output text is 'The show has been a bit of a success, thanks to the team'

  @Bug
  Scenario: Check sentance unchanged Bug
    Given I call the word filter endpoint
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a great show, thanks to the team'
     Then the output text is 'It's been a bit of a great show, thanks to the team'
  

