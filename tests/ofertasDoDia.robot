*** Settings ***
Library    SeleniumLibrary

Test setup      Run Keywords     Open Browser   https://www.mercadolivre.com.br    chrome  AND  Maximize Browser Window
Test Teardown   Close Browser 

*** Variables ***
${label_oferta_do_dia}     //section[@aria-label="Ofertas do dia"]//a
${button_seguinte}         //section[@aria-label="Ofertas do dia"]//button[@aria-label="Seguinte"]

*** Test Cases ***
Validar as ofertas do dia
    ${n}    Get Element Count    ${label_oferta_do_dia}
    Log To Console    \n
    Wait Until Element Is Visible    ${button_seguinte}
    Scroll Element Into View         ${label_oferta_do_dia}
    FOR    ${i}    IN RANGE  1   ${n}+1
        ${produto}    Get Text    (${label_oferta_do_dia})[${i}]
        Log To Console   ${produto}  
        ${div}    Evaluate    ${i}%4
        IF   ${div}==0
          Wait Until Keyword Succeeds   2s   6s   Click Element  ${button_seguinte} 
        END
    END