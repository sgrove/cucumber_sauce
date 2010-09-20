Feature: As a user, I want search results returned

Scenario Outline: Return Search Results for a term
Given I am on the Google Homepage
When I enter a "<term>"
Then the search results should include "<result>"  

Examples: Correct Results
    | term   | result  |
    | banana | fruit   |
    | cheese | Cheddar |

Examples: Incorrect Results
    | term   | result           |
    | banana | Jim Hacker       |
    | cheese | Humphrey Appleby |
    | steak  | Bernard Woolley  |


