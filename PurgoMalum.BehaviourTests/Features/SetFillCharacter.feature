@Fill_Character
Feature: Set fill character
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to set the character to replace profain content
	
  Scenario: Check custom replacement character
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement character as '_'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit of a ____ show, no thanks to that _____'

  Scenario Outline: Check supported custom replacement special character
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement character as '<input>'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is '<result>'
  
    Examples: 
      | input | result                                                  | 
      | _     | It's been a bit of a ____ show, no thanks to that _____ | 
      | ~     | It's been a bit of a ~~~~ show, no thanks to that ~~~~~ | 
      | -     | It's been a bit of a ---- show, no thanks to that ----- | 
      | =     | It's been a bit of a ==== show, no thanks to that ===== | 

  Scenario Outline: Check unsupported custom replacement special character
    Given I call the word filter endpoint
      And I specify the response type as 'plain'
      And I specify profain word replacement character as '<input>'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is '<result>'
  
    Examples: 
      | input | result                              | 
      | !     | Invalid User Replacement Characters | 
