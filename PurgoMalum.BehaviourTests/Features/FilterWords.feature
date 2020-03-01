@Filter_Words
Feature: Filter words
In order to avoid displaying content of profanity, obscenity and other unwanted text
As a content provider
I want to be able to filter such content

  Scenario: 1. Check default profain word replacement
    Given I call the word filter service
      And I specify the response type as 'xml'
     When I enter 'shit'
     Then the output text is '****'

  Scenario: 2. Check profain word is replaced in a sentence
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter 'It's been a bit shit show, no thanks to that bitch'
     Then the output text is 'It's been a bit **** show, no thanks to that *****'

@Bug
  Scenario Outline: 3. Check sentance unchanged 
    Given I call the word filter service
      And I specify the response type as 'json'
     When I enter '<input>'
     Then the output text is '<input>'

    Examples:
    | input                                                    |
    | The show has been a bit of a success, thanks to the team |
    | It's been a bit of a great show, thanks to the team      |

@Example
  Scenario Outline: 3. Advanced examples
    Given I call the word filter service
      And I specify the response type as '<input type>'
      And I specify profain word replacement text as '<replacement word>'
      And I specify profain word replacement character as '<replacement character>'
     And I add these words to the replacement list '<black list>'
     When I enter 'this is some test input'
     Then the output text is '<result>'

    Examples:
    | input type | black list | replacement word | replacement character | result                              |
    | xml        | this, some | [replaced]       |                       | [replaced] is [replaced] test input |
    | json       | input      |                  | _                     | this is some test _____             |