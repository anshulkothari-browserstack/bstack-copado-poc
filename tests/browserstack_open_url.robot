*** Settings ***
Library    SeleniumLibrary
Library    Process
Suite Setup    Install Python Dependencies

*** Variables ***
${TEST_URL}    %{TEST_URL=https://browserstack.github.io/bs-a11y-checks/all/index.html}
${PYTHON_CMD}    %{PYTHON_CMD=python3}
${REQUIREMENTS_FILE}    ${CURDIR}${/}..${/}requirements.txt

*** Test Cases ***
Open URL On BrowserStack
    Open Browser    ${TEST_URL}    browser=Chrome
    Wait Until Page Contains    Example Domain    15s
    [Teardown]    Close Browser

*** Keywords ***
Install Python Dependencies
    ${result}=    Run Process    ${PYTHON_CMD}    -m    pip    install    -r    ${REQUIREMENTS_FILE}
    Should Be Equal As Integers    ${result.rc}    0    msg=Dependency install failed: ${result.stderr}
