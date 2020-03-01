@Add
Feature: Add black list
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to be able to add a black list of words to filter

  Scenario: 1. Check add to black list
    Given I call the word filter service
      And I specify the response type as 'json'
      And I add these words to the replacement list 'fool,freak'
     When I enter 'Dont be a fool, you freak'
     Then the output text is 'Dont be a ****, you *****'

  Scenario: 2. Check black list maximum allowed words
    Given I call the word filter service
      And I specify the response type as 'json'
      And I add these words to the replacement list 'fool,freak,friend,foe,color,age,gender,sex,creed,kind,class'
     When I enter 'Dont be a fool, you freak'
     Then the output error is 'User Black List Exceeds Limit of 10 Words.'

@Bug
  Scenario Outline: 3. Check black list supported characters
    Given I call the word filter service
      And I specify the response type as 'json'
      And I add these words to the replacement list '<add>'
     When I enter '<input>'
     Then the output text is '<result>'
  
    Examples: 
      | add           | input                        | result                       | 
      | 01            | 01 Dont be a fool, you freak | ** Dont be a fool, you freak | 
      | freaky_friday | It's freaky_friday           | It's *************           | 
      | freaky,friday | It's freaky_friday           | It's ******_******           | 


  Scenario Outline: 4. Check black list unsupported characters
    Given I call the word filter service
      And I specify the response type as 'json'
      And I add these words to the replacement list '<add>'
     When I enter 'It's freaky friday'
     Then the output error is 'Invalid Characters in User Black List'
  
    Examples: 
      | add | 
      | _   | 
      | ~   | 
      | !   | 
      | -   | 
      | =   | 
      | '   | 
      | "   | 
      | *   | 
      | {}  | 
      | []  | 
      | ()  | 

@Bug
  Scenario: 5. Check filter is case-insensitive
    Given I call the word filter service
      And I specify the response type as 'json'
      And I add these words to the replacement list 'FOOL'
     When I enter 'Dont be a fool, you freak'
     Then the output text is 'Dont be a ****, you freak'