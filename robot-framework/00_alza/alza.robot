*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser    ${ALZA_PAGE}    Chrome
Suite Teardown    Close Browser
Test Setup    Go To Homepage

*** Test Cases ***
First Test
    Add Product(ProductName)    ${PRODUCT_NAME}

Second Test
    Check Added Product(ProductName)    ${PRODUCT_NAME}

Third Test
    Delete Product

Fourth Test
    Go To RootPage

*** Keywords ***
Add Product(ProductName)
    [Arguments]    ${PRODUCT_NAME}
    Wait Until Element Is Visible    ${FULLTEXT_SEARCH}
    Wait Until Element Is Enabled    ${FULLTEXT_SEARCH}

    Set focus to element    ${COOKIE_ACCEPT_BUTTON}
    Click element    ${COOKIE_ACCEPT_BUTTON}

    Set focus to element    ${FULLTEXT_SEARCH}
    Click element    ${FULLTEXT_SEARCH}
    Input text    ${FULLTEXT_SEARCH}    ${PRODUCT_NAME}

    Wait Until Element Is Enabled    ${SEARCH_BUTTON}
    Set focus to element    ${SEARCH_BUTTON}
    Double Click element    ${SEARCH_BUTTON}

    Wait Until Element Is Enabled    ${PURCHASE_BUTTON}
    Set focus to element    ${PURCHASE_BUTTON}
    Click element    ${PURCHASE_BUTTON}

    Wait Until Element Is Visible    ${ADD_MORE_BUTTON}    timeout=10s
    Scroll Element Into View         ${ADD_MORE_BUTTON}
    
Check Added Product(ProductName)
    [Arguments]    ${PRODUCT_NAME}
   Wait Until Element Is Visible    ${BASKET_BUTTON}
   Wait Until Element Is Enabled    ${BASKET_BUTTON}
   Set focus to element    ${BASKET_BUTTON}
   Click element    ${BASKET_BUTTON}
   Wait Until Page Contains    ${PRODUCT_NAME}

Delete Product
   Wait Until Element Is Visible    ${BASKET_BUTTON}
   Wait Until Element Is Enabled    ${BASKET_BUTTON}
   Set focus to element    ${BASKET_BUTTON}
   Click element    ${BASKET_BUTTON}
   
   Wait Until Element Is Visible    ${REMOVE_BUTTON}
   Wait Until Element Is Enabled    ${REMOVE_BUTTON}
   Set focus to element    ${REMOVE_BUTTON}
   Click element    ${REMOVE_BUTTON}

   Wait Until Element Is Visible    ${CONFIRM_REMOVE_BUTTON}    timeout=10s
   Scroll Element Into View         ${CONFIRM_REMOVE_BUTTON}
   Set focus to element    ${CONFIRM_REMOVE_BUTTON}
   Click element    ${CONFIRM_REMOVE_BUTTON}
   
   Wait Until Element Is Visible    ${REMOVE_BUTTON}    timeout=10s
   Wait Until Element Is Enabled    ${REMOVE_BUTTON}
   
   
   Reload page
   Wait Until Page Contains    ${EMPTY_BASKET}    timeout=10s

Go to rootPage
    Go To    ${ALZA_PAGE}

Go To Homepage
    Go To    ${ALZA_PAGE}
    SeleniumLibrary.Wait Until Page Contains Element    ${BASKET_BUTTON}    timeout=15s
    SeleniumLibrary.Maximize Browser Window

*** Variables ***
#elements
${FULLTEXT_SEARCH}    //*[@id="page"]/div[2]/div/div/div[1]/div/header/div[7]/div/div/div/input
${SEARCH_BUTTON}    //*[@id="page"]/div[2]/div/div/div[1]/div/header/div[7]/div/div/button
${PURCHASE_BUTTON}    //*[@id="boxes"]/div[1]/div[2]/div[2]/span
${REMOVE_BUTTON}    //div[contains(@class, "countMinus")]
${ADD_MORE_BUTTON}    //span[contains(@class, "count-edit__plus js-count-plus")]
${BASKET_BUTTON}    //*[@id="page"]/div[2]/div/div/div[1]/div/header/div[6]/a
${CONFIRM_REMOVE_BUTTON}    //div[@id="alzaDialog"]//span[contains(text(), "Odebrat zboží")]
${COOKIE_ACCEPT_BUTTON}    //*[@id="rootHtml"]/body/div[8]/div/div/div[2]/a[1]
#inputs
${ALZA_PAGE}    https://www.alza.cz
${PRODUCT_NAME}    iPhone 16 Pro
${EMPTY_BASKET}    Jsem tak prázdný...