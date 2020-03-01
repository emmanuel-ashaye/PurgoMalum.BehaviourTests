@Fill_Text
Feature: Set fill text
	In order to avoid displaying content of profanity, obscenity and other unwanted text
	As a content provider
	I want to set the text to replace profain content
	
  Scenario: 1. Check custom replacement text
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement text as 'blank'
     Then the output text is 'It's been a bit of a blank show, no thanks to that blank'

  Scenario Outline: 2. Check supported replacement text with special characters
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement text as '<input>'
     Then the output text is '<result>'

    Examples: 
      | input | result                                             | 
      | _     | It's been a bit of a _ show, no thanks to that _   |
      | ~     | It's been a bit of a ~ show, no thanks to that ~   |
      | !     | It's been a bit of a ! show, no thanks to that !   |
      | -     | It's been a bit of a - show, no thanks to that -   |
      | =     | It's been a bit of a = show, no thanks to that =   |
      | \|    | It's been a bit of a \| show, no thanks to that \| |
      | '     | It's been a bit of a ' show, no thanks to that '   |
      | "     | It's been a bit of a " show, no thanks to that "   |
      | *     | It's been a bit of a * show, no thanks to that *   |
      | {}    | It's been a bit of a {} show, no thanks to that {} |
      | []    | It's been a bit of a [] show, no thanks to that [] |
      | ()    | It's been a bit of a () show, no thanks to that () |

  Scenario Outline: 3. Check unsupported replacement text with special characters
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement text as '<input>'
     Then the output error is 'Invalid User Replacement Text'

    Examples: 
      | input | 
      | ,     | 
      | /     |
      | \     |

  Scenario: 4. Check custom replacement text limit
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
      And I specify profain word replacement text as 'supercalifragilisticexpialidocious'
     Then the output error is 'User Replacement Text Exceeds Limit of 20 Characters.'
