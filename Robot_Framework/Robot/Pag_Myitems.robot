*** Settings ***
Library  Selenium2Library

Resource  Keywords.robot
Resource  Variables.robot

# Suite teardown    Close all browsers

***Test Cases***
# Funtion Add Items(Page Card List)
Open Browser
    Open URL
  
# Add Item Success
#     Click Add Item_Success
#     Check Books List    

# Add Item Fail Type
#     Click Add Item_Fail Type
    
# Add Item Fail URL Error
#     Click Add Item_Fail URL


# Funtion plus Item(Page Card List)
plus Item Success
    plus Item_Success 

plus Item Fail
    plus Item_Fail

Page Your Items
    Go to Your Items
    Check items_item      

# Funtion plus Item(Summary)
Page Your Items
    Go to Summary
    Check item_Summary

Input Price item // Order Update
    Click Button        id=summary-btn-order-update

Delete Card  

Amazon   
    Go to Amazon      
    Check data Amazon

# Funtion plus Item(You Order) 
Go Your Order
    Click Element                ${navbar-account}
    Click Element                ${list-order}

Varify page your Order
    Element Text Should Be      ${Myorder-title}                ${Page_your_order}

Check Items
    Element Text Should Be      ${your_order_title}             ${Books1_title}
    Element Text Should Be      ${your_order_author_format}     ${Books1_author}(${Books1_format})
Plus item
    Click Button        id="order-plus-button"
    Element Text Should Be             id="order-amount"            3

Minus item
    Click Button        id="roder-minus-button"
    Element Text Should Be             id="order-amount"            2
Delete card
    Click Element       id="order-delete-button"    
    Element Should Not Contain      ${your_order_title}             ${Books1_title}
    Element Should Not Contain      ${your_order_author_format}     ${Books1_author}(${Books1_format})
