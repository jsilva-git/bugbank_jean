*** Settings ***
Library           BuiltIn
Library           SeleniumLibrary


*** Variables ***
${url}                            https://bugbank.netlify.app/
${valid_email}                    bugbank@gmail.com
${form_email}                     (//input[contains(@type,'email')])[2]
${form_name}                      //input[contains(@type,'name')]
${valid_name}                     jean
${form_password}                  (//input[contains(@type,'password')])[2]
${form_password_confirmation}     //input[contains(@placeholder,'Informe a confirmação da senha')]
${valid_password}                 automation123!@#
${balance_toggle}                 //label[contains(@class,'styles__Input-sc-1pngcbh-1 dTSgXK')]
${button_registration}            //button[@type='button'][contains(.,'Registrar')]
${button_register}                //button[@type='submit'][contains(.,'Cadastrar')]
${button_login}                   //button[@type='submit'][contains(.,'Acessar')]
${form_email_login}               (//input[contains(@type,'email')])[1]
${form_password_login}            (//input[contains(@type,'password')])[1]
${button_register_alert}          //a[@class='styles__Button-sc-8zteav-5 gyHUvN'][contains(.,'Fechar')]
${header_welcome}                 //p[@class='home__Text-sc-1auj767-9 jjmPHj'][contains(.,'bem vindo ao BugBank :)')]
${account_number}                 279
${account_digit}                  5
${transfer_amount}                500
${transfer_description}           This is a test transfer.
${button_transaction}             //a[contains(@id,'btn-TRANSFERÊNCIA')]
${form_accountnumber}             //input[contains(@type,'accountNumber')]
${form_accountdigit}              //input[contains(@type,'digit')]
${form_transferamount}            //input[contains(@type,'transferValue')]
${form_description}               //input[contains(@type,'description')]
${button_transfer}                //button[@type='submit'][contains(.,'Transferir agora')]
${register_confirmation_message}  //p[contains(@id,'modalText')]
${button_close}                   //a[@class='styles__Button-sc-8zteav-5 gyHUvN'][contains(.,'Fechar')]    #locator for the button that closes the transfer confirmation window
${button_back}                    //a[@class='transfer__BackText-sc-1yjpf2r-5 gWmJSZ'][contains(.,'Voltar')]
${button_back2}                   //a[@class='bank-statement__BackText-sc-7n8vh8-6 fFgHWM'][contains(.,'Voltar')]
${button_statement}               //a[contains(@id,'btn-EXTRATO')]
${button_logout}                  //a[@class='styles__Link-sc-osobjw-0 xzjxU'][contains(.,'Sair')]

*** Keywords ***

 Open Bugbank Browser
     Open Browser    ${url}    Chrome
    Maximize Browser Window
Given the user is on the registration page
    Wait Until Page Contains    text=Faça transferências e pagamentos com bugs e pratique testes com sucesso em um cenário quase real!
    Click Element               locator=${button_registration}
    Wait Until Page Contains    text=Voltar ao login

When the user enters valid credentials
    Wait Until Page Contains    text=Criar conta com saldo ?
    Input Text        locator=${form_email}                    text=${valid_email}
    Input Text        locator=${form_name}                     text=${valid_name}
    Input Password    locator=${form_password}                 password=${valid_password}
    Input Password    locator=${form_password_confirmation}    password=${valid_password}
    Click Element     locator=${balance_toggle}
    Sleep    3    
    Click Element     locator=${button_register}

Then the user should see the account number
    Wait Until Element Is Visible    locator=${register_confirmation_message} 
    Click Element    locator=${button_register_alert}

Given the user is on the login page
    Wait Until Element Is Visible    locator=${button_login}
    
When the user inputs valid login credentials
    Input Text       locator=${form_email_login}       text=${valid_email}
    Input Text       locator=${form_password_login}    text=${valid_password}
    Click Element    locator=${button_login}

Then the user should be redirected to the home page
    Wait Until Element Is Visible    locator=${header_welcome}

Given the user is on the home page
    Wait Until Element Is Visible    locator=${header_welcome}

When the user clicks the transaction button
    Wait Until Element Is Visible    locator=${button_transaction}
    Click Element                    locator=${button_transaction}

And inputs the valid information
    Wait Until Page Contains    text=Realize transferência de valores entre contas BugBank com taxa 0 e em poucos segundos.
    Input Text    locator=${form_accountnumber}     text=${account_number}
    Input Text    locator=${form_accountdigit}      text=${account_digit}
    Input Text    locator=${form_transferamount}    text=${transfer_amount}
    Input Text    locator=${form_description}       text=${transfer_description}
    Sleep    3
    Click Element    locator=${button_transfer}

Then the user should see a transaction failed message
    Wait Until Element Is Visible    locator=${button_close}
    Click Element                    locator=${button_close}
    Wait Until Element Is Visible    locator=${button_back}
    Click Element                    locator=${button_back} 

When the user clicks the statement button
    Wait Until Element Is Visible    locator=${button_statement}
    Click Element                    locator=${button_statement}

Then he should see the statement details
    Wait Until Page Contains    text=Saldo adicionado ao abrir conta
    Log                         Conta criada com saldo!
    Wait Until Element Is Visible    locator=${button_back2}
    Click Element                    locator=${button_back2}

When the user clicks the Logout button
    Wait Until Element Is Visible    locator=${button_logout}
    Click Element                    locator=${button_logout}

Then the user should be redirected to the login page
    Wait Until Page Contains    text=O banco com bugs e falhas do seu jeito
    Log    Logout realizado com sucesso!
    Sleep    3