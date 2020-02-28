Feature: Add black list
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to be able to add a black list of words to filter
	
@Add
  Scenario: Check add to black list
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I add these words to the replacement list 'fool,freak'
     When I enter 'Dont be a fool, you freak'
     Then the output text is 'Dont be a ****, you *****'

  Scenario: Check black list maximum allowed words
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I add these words to the replacement list 'fool,freak,friend,foe,color,age,gender,sex,creed,kind,class'
     When I enter 'Dont be a fool, you freak'
     Then the output text is 'User Black List Exceeds Limit of 10 Words.'

@Bug
  Scenario: Check black list allows numbers
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I add these words to the replacement list '01'
     When I enter '01 Dont be a fool, you freak'
     Then the output text is '** Dont be a fool, you freak'
@Bug
  Scenario: Check black list allows special characters
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I add these words to the replacement list 'freaky_friday'
     When I enter 'It's freaky_friday'
     Then the output text is 'It's *************'