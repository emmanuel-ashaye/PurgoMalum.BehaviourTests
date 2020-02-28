Feature: ProfainWordFilter
In order to avoid displaying content of profanity, obscenity and other unwanted text
As a content provider
I want to be a ble to filter such content

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
  Scenario: Check sentance unchanged fail
    Given I call the word filter endpoint
      And I specify the response type as 'json'
     When I enter 'It's been a bit of a great show, thanks to the team'
     Then the output text is 'It's been a bit of a great show, thanks to the team'
  
  Scenario: Check custom replacement word
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement as 'blank'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit of a blank show, no thanks to that blank'

  Scenario: Check custom replacement word with special characters
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement as '_~!-=|*'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit of a _~!-=|* show, no thanks to that _~!-=|*'

  Scenario: Check custom replacement word with unsupported special characters
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement as '_~!-=|*,'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'Invalid User Replacement Text'

  Scenario: Chech custom replacement character
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I specify profain word replacement character as '_'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit of a ____ show, no thanks to that _____'

  Scenario Outline: Chech supported custom replacement special character
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

  Scenario Outline: Chech unsupported custom replacement special character
    Given I call the word filter endpoint
      And I specify the response type as 'plain'
      And I specify profain word replacement character as '<input>'
     When I enter 'It's been a bit of a shit show, no thanks to that bitch'
     Then the output text is '<result>'
  
    Examples: 
      | input | result                              | 
      | !     | Invalid User Replacement Characters | 

  Scenario: Chech add to profain list
    Given I call the word filter endpoint
      And I specify the response type as 'json'
      And I add these words to the replacement list 'fool,freak'
     When I enter 'Dont be a fool, you freak'
     Then the output text is 'Dont be a ****, you *****'
