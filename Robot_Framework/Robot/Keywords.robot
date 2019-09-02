
*** Keywords ***
Open URL
    Open Browser            ${URL}       ${Browser}
    Set selenium speed      1
    Verify_odds++

Verify_odds++
    # Wait Until Element Contains     ${Logo}
    sleep       3s
    Page Should Contain Image       ${Logo} 

Login 
    Input Text                  ${Input_User}              ${User}            
    Input Password              ${Input_Password}          ${Password}

Click Add Item_Success
    Click Element                   ${Button_Add}
    Input Text                      ${Path_URL}            ${Books1_URL} 
    Click Element                   ${Button_Fetch}
    Check Data Add-Item Success 
    Click Button                 ${button_Save}
    sleep       2s
   
Check Data Add-Item Success
    sleep       5s 
    Element Text Should Be      ${Path_title}               ${Books1_title} 
    Element Text Should Be      ${Path_author}              ${Books1_author}   
    Element Text Should Be      ${Path_price}               ${Books1_price}    
    Element Text Should Be      ${Path_format}              ${Books1_format}     
    Input Text                  ${Path_date}                ${Books1_date} 
    

Check Books List
    Element Text Should Be      ${List_title}               ${Books_List_title}
    Element Text Should Be      ${List_author}              ${Books1_author} (${Books1_format})  
    Element Text Should Be      ${List_price}               ${Books1_price}    
    Element Text Should Be      ${List_date}                ${Books1_date} 

Click Add Item_Fail Type
    Click Element               ${Button_Add}
    Input Text                  ${Path_URL}                 ${Books1_Type_Fail} 
    Click Element               ${Button_Fetch}
    Check Books Fail Type 
    Close Browser

Check Books Fail Type
    sleep       3s                        
    Element Text Should Be      ${Message}                  ${Status_Error Type}      


Click Add Item_Fail URL
    Open URL
    Click Element                ${Button_Add}
    Input Text                   ${Path_URL}               ${Books1_URL_Fail}          
    Click Element                ${Button_Fetch}
    Check Books Fail URL 
    Close Browser

Check Books Fail URL 
    sleep       3s                        
    Element Text Should Be       ${Message}                 ${Status_Error URL}  

plus Item_Success  
    Open URL
    Click Button                 ${add_plus_btn}
    Click Element                ${plus_btn}            
    Click Button                 ${confirm_btn}
    Verify_Show_Order_Success

Verify_Show_Order_Success
    Click Button                 ${show_list_btn}
    Element Text Should Be       ${Order_name}              ${User_name}   
    Element Text Should Be       ${Order_count}             ${Plus_Count_books}
    Close Browser     

plus Item_Fail
    Open URL
    Click Button                ${add_plus_btn}
    Click Element               ${minus_btn}
    Element Text Should Be      ${Count_books_current}      ${Default_Count_books}
    Click Button                ${Cancle_btn} 
    Verify_Show_Order_Success

Verify_Show_Order_Success
    Click Button                 ${show_list_btn}
    Element Text Should Be       ${Order_name}              ${User_name}   
    Element Text Should Be       ${Order_count}             ${Default_Count_books}
    Close Browser 

Go to Your Items
    Click Element                ${navbar-account}
    Click Element                ${list-item}
    Varify page Your Items

Varify page Your Items 
    Element Text Should Be      ${Myitem_page}           ${Page_Myitem}        
   
Check items_item
    Element Text Should Be      ${Summary-nam e}         ${Books1_title}
    Element Text Should Be      ${Summary-count}         ${Default_Count_books}

    Element Text Should Be      id=summary-Costs($)      ${Default_Count_books}
    Element Text Should Be      id=summary-Charge($)     ${Default_Count_books}

Go to Summary
        Click Button            ${Myitem_summary_btn}
        Varify Summary

Varify Summary
        
Check item_Summary
    Element Text Should Be      ${Summary-title}            ${Books1_title}
    Element Text Should Be      ${Summary-author}           ${Books1_author}
    Element Text Should Be      ${Summary-price}            ${Books1_price} 
    Element Text Should Be      ${Summary-order-date}      ${Books1_date}

Check item_Summary
    Item total
    Price total
    Charge total

Item total
    Element Text Should Be      ${Total_Item}           ${Input_Total_Item}

Price total
    Element Text Should Be      ${Total_price}          ${Input_Total_price}

Charge total
    Element Text Should Be      ${Total_Charge}         ${Input_Total_Charge}     


Input price item 
    Click Button        ${order_update_btn}

Input change 
    Input Text          500
Check price
    Input Text          100
Submit
    Click Button        id=result-modal-submit-btn

Varify Order Summary
    Element Text Should Be      id=summary-Costs($)         500
    Element Text Should Be      id=summary-Charge($)        $10

Delete Item Card
       Go to Your Items
       Click Element       
       Click Element       
     
Go to Amazon     
    Click Button        id=summary-btn-go-to-amazon

Check data Amazon
    Element Text Should be      id=productTitle        ${Books1_title}   


