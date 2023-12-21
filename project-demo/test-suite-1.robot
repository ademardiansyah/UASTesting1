*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     headlesschrome
${HOST}    http://localhost:8000

${EMAIL}    super@admin.com
${PASS-1}    secret    # correct password
${PASS-2}    xxs12s2    # wrong password

${COMPANY}    global.inc
${TITLE}    [TEST] Senior Engineering manager
${LOCATION}     Singapore
${TAGS}    engineering manager software
${JOBEMAIL}    jobs@global.co
${WEBSITE}    https://global.co
${DESCRIPTION}     Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

*** Test Cases ***

# login
# positive test
testcase-1
    Login Success
    Close Browser    

# negative test
testcase-2
    Open Browser    ${HOST}    ${BROWSER}
    Click Element     xpath://a[@href='http://localhost:8000/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-2}
    Click Element     xpath://button[@type='submit']
    Close Browser 

# logout
testcase-3
    Login Success
    Click Element     xpath://button[@id='user-menu-button']
    click Element     xpath://a[@href='http://localhost:8000/logout']
    Page Should Contain Element    xpath://a[@href='http://localhost:8000/login']
    Close Browser 

#post job
testcase-4
    Login Success
    Click Element     xpath://a[@href='http://localhost:8000/posts']
    Scroll Down Until End
    Close Browser 

*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
    Open Browser    ${HOST}    ${BROWSER}
    Click Element     xpath://a[@href='http://localhost:8000/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']