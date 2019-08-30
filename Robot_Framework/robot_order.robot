*** Settings ***
Library          Selenium2Library
Test Teardown   Close Browser

*** Test cases ***
Check open wep page my order
    Open Odds Plus Plus
    Open URL My Order
    Show header text
Check My Order
    Open Odds Plus Plus
    Open URL My Order
    Check card my order
    
*** Keywords ***
Open Odds Plus Plus
    Open Browser                  ${URL}       ${Browser}
    Set selenium speed            1
Open URL My Order
    Click Element                 ${Button_navbar}
    Click Element                 ${Button_menu}
Show header text
    Element Should Contain        id=myorder-title     Your Orders
Check card my order
    Get Element Count             ${Order_amount}
    Page Should Contain Image     ${List_image}

*** Variables ***
${Browser}               Chrome
${URL}                   localhost:8080/home

${Button_navbar}        id=navbar-account-bar
${Button_menu}          id=navbar-list-order

${List_image}           id=card-boot-image
${Order_amount}         id=order-amount 
