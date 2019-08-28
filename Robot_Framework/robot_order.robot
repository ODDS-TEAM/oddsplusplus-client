*** Settings ***
Library          Selenium2Library

*** Test cases ***
Check Order 
    Open Wep Odds Plus Plus 
    Cleck Element  card-plus-button
    Click Element  navbar-account-bar
    Click Element  navbar-list-order

*** Keywords ***
Open Wep Odds Plus Plus 
    Open Browser  localhost:8080  Chrome
*** Variables ***
