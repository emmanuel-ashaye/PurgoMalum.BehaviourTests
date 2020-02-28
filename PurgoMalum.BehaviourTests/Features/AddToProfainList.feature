Feature: Add to profain list
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to be able to add to the list of words to filter
	
@Add
  Scenario: Check add to profain list
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I add these words to the replacement list 'fool,freak'
     When I enter 'Dont be a fool, you freak'
     Then the output text is 'Dont be a ****, you *****'
