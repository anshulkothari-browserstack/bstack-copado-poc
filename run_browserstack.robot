*** Settings ***
Library    Process

*** Variables ***
${SDK_CMD}    browserstack-sdk
${TARGET_SUITE}    tests/browserstack_open_url.robot

*** Test Cases ***
Run BrowserStack SDK Suite
    ${result}=    Run Process    ${SDK_CMD}    robot    ${TARGET_SUITE}    cwd=${EXECDIR}
    Should Be Equal As Integers    ${result.rc}    0    msg=BrowserStack SDK run failed: ${result.stderr}
    Log    ${result.stdout}
