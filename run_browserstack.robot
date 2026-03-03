*** Settings ***
Library    Process

*** Variables ***
${PYTHON_CMD}    %{PYTHON_CMD=python}
${REQUIREMENTS_FILE}    ${EXECDIR}${/}requirements.txt
${TARGET_SUITE}    tests/browserstack_open_url.robot

*** Test Cases ***
Run BrowserStack SDK Suite
    ${install}=    Run Process    ${PYTHON_CMD}    -m    pip    install    -r    ${REQUIREMENTS_FILE}    cwd=${EXECDIR}
    Should Be Equal As Integers    ${install.rc}    0    msg=Dependency install failed. STDOUT: ${install.stdout} STDERR: ${install.stderr}

    ${result}=    Run Process    ${PYTHON_CMD}    -m    browserstack_sdk    robot    ${TARGET_SUITE}    cwd=${EXECDIR}
    IF    ${result.rc} != 0
        ${fallback}=    Run Process    browserstack-sdk    robot    ${TARGET_SUITE}    cwd=${EXECDIR}
        Should Be Equal As Integers    ${fallback.rc}    0    msg=BrowserStack SDK run failed. PYTHON MODULE STDOUT: ${result.stdout} PYTHON MODULE STDERR: ${result.stderr} FALLBACK STDOUT: ${fallback.stdout} FALLBACK STDERR: ${fallback.stderr}
    ELSE
        Log    ${result.stdout}
    END
