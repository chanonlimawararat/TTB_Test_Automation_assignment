*** Settings ***
Library    Selenium2Library

*** Variables ***
${browser}    chrome
${url}    http://the-internet.herokuapp.com/login
${Account_Tomsmith}     tomsmith
${Input_Username}  username
${Input_Password}  password
${Error_MSG}  flash


*** Keywords ***

# Login Page
Open http://the-internet.herokuapp.com/login
    Open Browser     ${url}     ${browser}

Login Success
    Input Text    id:${Input_Username}    tomsmith
    Input Text    id:${Input_Password}    SuperSecretPassword!

Login Fail
    Input Text    id:${Input_Username}    tomsmith
    Input Text    id:${Input_Password}    Password!

Login Username not found
    Input Text    id:${Input_Username}    tomholland
    Input Text    id:${Input_Password}    Password!


Click Button Login 
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    timeout=5s
    Click Element    xpath=//button[@type="submit"]


Check Logout Success 
    Wait Until Element Is Visible    id:${Error_MSG}    timeout=5s
    Element Text Should Be    id:${Error_MSG}    You logged out of the secure area!\n×
    Sleep    5s


# secure Page
Check MSG You logged into a secure area
    Wait Until Element Is Visible    id:${Error_MSG}    timeout=5s
    Element Text Should Be    id:${Error_MSG}    You logged into a secure area!\n×
    Sleep    5s

Click Button Logout
    Wait Until Element Is Visible    xpath=//*[@id="content"]/div/a    timeout=5s
    Click Element    xpath=//*[@id="content"]/div/a
    Sleep    5s

Check Error Your password is invalid  
    Wait Until Element Is Visible    id:${Error_MSG}    timeout=5s
    Element Text Should Be    id:${Error_MSG}    Your password is invalid!\n×
    Sleep    5s

Check Error Username not found 
    Wait Until Element Is Visible    id:${Error_MSG}    timeout=5s
    Element Text Should Be    id:${Error_MSG}    Your username is invalid!\n×
    Sleep    5s


*** Test Cases ***
Case: Login success
   Open http://the-internet.herokuapp.com/login
   Login Success
   Click Button Login
   Check MSG You logged into a secure area
   Click Button Logout
   Check Logout Success 

Case: Password incorrect
    Open http://the-internet.herokuapp.com/login
    Login Fail
    Click Button Login 
    Check Error Your password is invalid  

Case: Username not found
    Open http://the-internet.herokuapp.com/login
    Login Username not found
    Click Button Login 
    Check Error Username not found 
