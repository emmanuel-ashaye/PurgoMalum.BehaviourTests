@Fill_Character
Feature: Set fill character
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to set the character to replace profain content
	
  Scenario: 1. Check custom replacement character
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement character as '_'
     Then the output text is 'It's been a bit of a ____ show, no thanks to that _____'

  Scenario Outline: 2. Check supported replacement characters
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement character as '<input>'
     Then the output text is '<result>'
  
    Examples: 
      | input | result                                                           | 
      | _     | It's been a bit of a ____ show, no thanks to that _____          | 
      | ~     | It's been a bit of a ~~~~ show, no thanks to that ~~~~~          | 
      | -     | It's been a bit of a ---- show, no thanks to that -----          | 
      | =     | It's been a bit of a ==== show, no thanks to that =====          | 
      | \|    | It's been a bit of a \|\|\|\| show, no thanks to that \|\|\|\|\| | 
      | *     | It's been a bit of a **** show, no thanks to that *****          | 

  Scenario Outline: 3. Check unsupported replacement characters
    Given I call the word filter service
      And I specify the response type as 'plain'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement character as '<input>'
     Then the output error is 'Invalid User Replacement Characters'
  
    Examples: 
      | input |
      | !     |
      | #     |
      | /     |
      | \     |
      | a     |
      | 8     |
