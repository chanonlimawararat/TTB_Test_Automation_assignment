*** Settings ***
Library    AppiumLibrary


*** Test Cases ***
Add a New Todo
    Open Test Appliction
    Click Add ToDo
    Input Value For Create New TODO    NewTODO
    Submit For Create TODO
    Check TODO List Text View    NewTODO

Add a New Todo and TrunOn RemindMe
    Open Test Appliction
    Click Add ToDo
    Input Value For Create New TODO    TrunOnRemindME
    TrunOn Toggle Remind ME
    Submit For Create TODO
    Check TODO List Text View    TrunOnRemindME
    Check TODO List In Remind Date Text View

Set Remind date is past
    Open Test Appliction
    Click Add ToDo
    Input Value For Create New TODO    RemindMeIsPart
    TrunOn Toggle Remind ME
    Click Edit Date Is Part
      
*** Keywords ***
Open Test Appliction
    Open Application    remote_url=http://localhost:4723/wd/hub  
    ...    platformName=Android    
    ...    platformVersion=8    
    ...    deviceName=Pixel 5  
    ...    appPackage=com.avjindersinghsekhon.minimaltodo
    ...    appActivity=com.example.avjindersinghsekhon.toodle.MainActivity
    ...    automationName=UiAutomator2


Click Add ToDo
    Wait Until Page Contains Element  id=com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB    30s
    Tap  id=com.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB

Input Value For Create New TODO
    [Arguments]    ${kw}
    Wait Until Page Contains Element  id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText    30s
    Input Text    id=com.avjindersinghsekhon.minimaltodo:id/userToDoEditText   ${kw} 

Submit For Create TODO
    Wait Until Page Contains Element  id=com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton    30s
    Tap  id=com.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton

Check TODO List Text View
    [Arguments]    ${kw}
     Wait Until Page Contains Element  id=com.avjindersinghsekhon.minimaltodo:id/toDoListItemTextview    30s
     Element Text Should Be    id=com.avjindersinghsekhon.minimaltodo:id/toDoListItemTextview    ${kw}

TrunOn Toggle Remind ME
    Wait Until Page Contains Element    id=com.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat
    ClickElement    id=com.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat

Check TODO List In Remind Date Text View
    Wait Until Page Contains Element  id=com.avjindersinghsekhon.minimaltodo:id/todoListItemTimeTextView    30s

Click Edit Date Is Part
    Wait Until Page Contains Element  id=com.avjindersinghsekhon.minimaltodo:id/newTodoDateEditText    30s
    Tap  id=com.avjindersinghsekhon.minimaltodo:id/newTodoDateEditText
    Click Element    xpath=//android.view.View[@content-desc="20 November 2024"]
    Tap     id=com.avjindersinghsekhon.minimaltodo:id/ok

