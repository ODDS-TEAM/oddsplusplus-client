
*** Keywords ***
Open URL
    Open Browser            ${URL}       ${Browser}
    Set selenium speed      1
    Verify_odds++

Verify_odds++
    Page Should Contain Image       ${Logo}       

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
    Element Text Should Be      ${List_author}              ${Books1_author}   
    Element Text Should Be      ${List_price}               ${Books1_price}    
    Element Text Should Be      ${List_date}                ${Books1_date} 

Click Add Item_Fail Type
    Click Element               ${Button_Add}
    Input Text                  ${Path_URL}                 ${Books1_Type_Fail} 
    Click Element               ${Button_Fetch}
    Check Books Fail Type 
    Click Element               ${Button_Cancle}

Check Books Fail Type
    sleep       5s                        
    Element Text Should Be      ${Message}                  ${Status_Error Type}      


Click Add Item_Fail URL
    Click Element                ${Button_Add}
    Input Text                   ${Path_URL}               ${Books1_URL_Fail}          
    Click Element                ${Button_Fetch}
    Check Books Fail URL 
    Click Element                ${Button_Cancle}

Check Books Fail URL 
    sleep       5s                        
    Element Text Should Be       ${Message}                 ${Status_Error URL}                                         
