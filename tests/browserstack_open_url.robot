*** Settings ***
Library    SeleniumLibrary
Library    Process
Library    Collections
Suite Setup    Install Python Dependencies

*** Variables ***
${TEST_URL}    %{TEST_URL=https://browserstack.github.io/bs-a11y-checks/all/typec.html}
${PYTHON_CMD}    %{PYTHON_CMD=python}
${REQUIREMENTS_FILE}    ${CURDIR}${/}..${/}requirements.txt
${BROWSERSTACK_USERNAME}    %{BROWSERSTACK_USERNAME=}
${BROWSERSTACK_ACCESS_KEY}    %{BROWSERSTACK_ACCESS_KEY=}
${REMOTE_URL}    https://${BROWSERSTACK_USERNAME}:${BROWSERSTACK_ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub

*** Test Cases ***
Open URL On BrowserStack
    ${options}=    Create BrowserStack Chrome Options
    Open Browser    ${TEST_URL}    browser=Chrome    remote_url=${REMOTE_URL}    options=${options}
    Wait Until Page Contains    Pause Moving Content Violations    20s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    5s
    [Teardown]    Close Browser

*** Keywords ***
Install Python Dependencies
    ${result}=    Run Process    ${PYTHON_CMD}    -m    pip    install    -r    ${REQUIREMENTS_FILE}
    Should Be Equal As Integers    ${result.rc}    0    msg=Dependency install failed: ${result.stderr}

Create BrowserStack Chrome Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${bstack_options}=    Create Dictionary
    ...    os=Windows
    ...    osVersion=10
    ...    projectName=COPADO_ROBOTIC
    ...    buildName=copado_robotic_build
    ...    sessionName=Open URL On BrowserStack
    ...    accessibility=${True}
    ${include_issue_type}=    Create Dictionary
    ...    bestPractice=${True}
    ...    needsReview=${True}
    ...    experimental=${True}
    ...    advanced=${True}
    ${accessibility_options}=    Create Dictionary
    ...    wcagVersion=wcag22aaa
    ...    includeIssueType=${include_issue_type}
    ...    scannerVersion=latest
    Set To Dictionary    ${bstack_options}    accessibilityOptions=${accessibility_options}
    Call Method    ${options}    set_capability    browserName    Chrome
    Call Method    ${options}    set_capability    browserVersion    latest
    Call Method    ${options}    set_capability    bstack:options    ${bstack_options}
    RETURN    ${options}
