*** Settings ***
Library  Selenium2Library

***Test Cases***
Open Browser
    Open URL

Add Item Success
    Click Add Item_Success
    Check Books List    

Add Item Fail Type
    Click Add Item_Fail Type
    
Add Item Fail URL Error
    Click Add Item_Fail URL

Close Browser After Finish
    Close Browser


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


*** Variables ***
${Browser}               Chrome
${URL}                   http://localhost:8080/
${Logo}                  xpath://img[contains(@src, "/img/odds_logo.a074357a.png")]

${Button_Add}            id=navbar-add-button
${Button_Fetch}          id=modal-fetch-button
${Path_URL}              id=modal-url-input
${Button_Submit}         id=modal-save-button

${Path_title}            id=modal-book-title
${Path_author}           id=modal-book-author 
${Path_price}            id=modal-book-price
${Path_format}           id=modal-book-format  
${Path_date}             id=modal-book-date
${button_Save}           id=modal-save-button

${List_title}            id=card-book-title
${List_author}           id=card-book-author
${List_price}            id=card-book-price
${List_format}           id=card-book-format
${List_date}             id=card-boot-order-date

${Books1_URL}            https://www.amazon.com/gp/product/0062866001/ref=s9_acsd_ri_bw_c_x_10_w?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-12&pf_rd_r=NHZQ553RZ42PQE5QZR0Q&pf_rd_t=101&pf_rd_p=b1b6e7c5-f122-45e8-9a8c-d025cdf29298&pf_rd_i=283155
${Books1_title}          The Good Egg         
${Books1_author}         By Jory John
${Books1_price}          $10.79
${Books1_format}         Hardcover
${Books1_date}           10/10/2019
${Books_List_title}      ${Books1_title} (${Books1_format})

${Books1_Type_Fail}       https://www.amazon.com/gp/product/B01N1UP614/ref=s9_acsd_ri_bw_c_x_1_w?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-10&pf_rd_r=13ES6RHAS1A01EFE7H85&pf_rd_t=101&pf_rd_p=b34f3048-7fa4-49b0-99af-8102f019a6c3&pf_rd_i=283155
${Status_Error Type}     Error : Format book invalid support for Paperback or Hardcover 


${Books1_URL_Fail}      https://www.youtube.com/watch?v=7e4ADkPbstU  
${Status_Error URL}     Error : URL is not amazon or invalid --> example : https://www.amazon.com/,https://amazon.com/

${Button_Cancle}         id=modal-cancel
${Message}               id=status
     

  

