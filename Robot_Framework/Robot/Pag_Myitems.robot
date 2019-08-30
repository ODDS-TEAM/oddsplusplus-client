Check page OODS++
*** Settings ***
Library  Selenium2Library
Resource  Keywords.robot
Resource  Variables.robot

***Test Cases***
Open Browser
    Open URL
    
Add books
    Click Add Item_Success

Go Your Items
# - Check page Your Items 
# - Check items 
# - ----------------------------
# - Go to Summary
# - Check data item 
# - Item many
# - Price
# - Charge
# - Go to Amazon
# - Check data Amazon
# - —————————————————
# - Input price item 
# - Input change 
# - Check price
# - ———————————————————
# - Delete Card

