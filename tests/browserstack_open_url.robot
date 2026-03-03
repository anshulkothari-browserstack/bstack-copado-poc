*** Settings ***
Library    SeleniumLibrary
Library    Process
Suite Setup    Install Python Dependencies

*** Variables ***
${TEST_URL}    %{TEST_URL=https://browserstack.github.io/bs-a11y-checks/all/index.html}
${PYTHON_CMD}    %{PYTHON_CMD=python}
${REQUIREMENTS_FILE}    ${CURDIR}${/}..${/}requirements.txt
${BROWSERSTACK_USERNAME}    %{BROWSERSTACK_USERNAME=}
${BROWSERSTACK_ACCESS_KEY}    %{BROWSERSTACK_ACCESS_KEY=}
${REMOTE_URL}    https://${BROWSERSTACK_USERNAME}:${BROWSERSTACK_ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub

&{CAPABILITIES}    browserName=Chrome    browserVersion=latest    os=Windows    osVersion=10
...    projectName=COPADO_ROBOTIC    buildName=copado_robotic_build    sessionName=Open URL On BrowserStack
...    browserstack.accessibility=true    browserstack.accessibility.wcagVersion=wcag22aaa

*** Test Cases ***
Open URL On BrowserStack
    Open Browser    ${TEST_URL}    browser=Chrome    remote_url=${REMOTE_URL}    desired_capabilities=${CAPABILITIES}
    Wait Until Page Contains    Pause Moving Content Violations    20s
    [Teardown]    Close Browser

*** Keywords ***
Install Python Dependencies
    ${result}=    Run Process    ${PYTHON_CMD}    -m    pip    install    -r    ${REQUIREMENTS_FILE}
    Should Be Equal As Integers    ${result.rc}    0    msg=Dependency install failed: ${result.stderr}
