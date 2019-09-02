
*** Variables ***
${Browser}               Chrome
${URL}                   http://localhost:8080/home
${Logo}                  xpath://*[@id="navbar-logo"]

${Input_User}            name=identifier
${Input_Password}        name=password
${User}                  jatdilok@odds.team
${Password}              Jatdilok04102537

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

${Books1_URL}            https://www.amazon.com/City-Girls-Novel-Elizabeth-Gilbert/dp/0593104366/ref=tmm_pap_swatch_0?_encoding=UTF8&qid=&sr=
${Books1_title}          City of Girls         
${Books1_author}         Elizabeth Gilbert
${Books1_price}          $18.22
${Books1_date}           15/10/2019
${Books1_format}         Paperback
${Books_List_title}      ${Books1_title}

${Books1_Type_Fail}      https://www.amazon.com/gp/product/B01N1UP614/ref=s9_acsd_ri_bw_c_x_1_w?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-10&pf_rd_r=13ES6RHAS1A01EFE7H85&pf_rd_t=101&pf_rd_p=b34f3048-7fa4-49b0-99af-8102f019a6c3&pf_rd_i=283155
${Status_Error Type}     Error : Format book invalid support for Paperback or Hardcover 


${Books1_URL_Fail}      https://www.youtube.com/watch?v=7e4ADkPbstU  
${Status_Error URL}     Error : URL is not amazon or invalid --> example : https://www.amazon.com/ , https://amazon.com/

${Button_Cancle}        id=modal-cancel
${Message}              id=addmodal-alert

${add_plus_btn}         id=card-plus-button
${plus_btn}             id=plusmodal-plus-button
${minus_btn}            id=plusmodal-minus-button
${confirm_btn}          id=plusmodal-confirm-button
${Cancle_btn}           id=plusmodal-cancel-button
${Count_books_current}  id=plusmodal-current 

${show_list_btn}        id=card-show-list-button
${add_plus_btn}         Show Order
${Order_name}           id=order.user.name
${Order_count}          id=order.count

${User_name}            Test Robot
${Plus_Count_books}     2
${Default_Count_books}  1

${navbar-account}       id=navbar-account-bar
${list-item}            id=navbar-list-item
${list-order}           id=navbar-list-order
${list-signout}         id="navbar-list-signout"

${Myitem_page}          id=Myitem-page-title
${Myitem_summary_btn}   id=myitem-summary
${Page_Myitem}          Your Items

${Summary-name}         id=summary-Name
${Summary-count}        id=summary-Qty

${Summary-title}        id=summary-title-format
${Summary-author}       id=summary-author
${Summary-price}        id=summary-price
${Summary-order-date}   id=summary-order-date

${Total_Item}           id=summary-total-qty
${Total_price}          id=summary-total-price
${Total_Charge}         id=summary-total-charge

${Input_Total_Item}     2
${Input_Total_price}    $36.44
${Input_Total_Charge}   $10
   
${order_update_btn}    id=summary-btn-order-update

${Myorder_title}       id=myorder-title

${Page_your_order}              Your Orders
${your_order_title}             id=item-title
${your_order_author_format}     id=item-author-format