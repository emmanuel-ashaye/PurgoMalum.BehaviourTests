Feature: Set fill text
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to set the text to replace profain content
	
@mytag
  Scenario: Check custom replacement text
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement as 'blank'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit of a blank show, no thanks to that blank'

  Scenario: Check custom replacement text with special characters
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement as '_~!-=|*'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit of a _~!-=|* show, no thanks to that _~!-=|*'

  Scenario: Check custom replacement text with unsupported special characters
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement as '_~!-=|*,'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'Invalid User Replacement Text'
