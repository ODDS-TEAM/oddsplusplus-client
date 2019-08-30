
*** Variables ***
${Browser}               Chrome
${URL}                   http://localhost:8080/home
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
   