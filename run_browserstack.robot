*** Settings ***
Library    Process

*** Variables ***
${PYTHON_CMD}    %{PYTHON_CMD=python}
${TARGET_SUITE_REL}    tests${/}browserstack_open_url.robot

*** Test Cases ***
Run BrowserStack SDK Suite
    ${requirements_file}=    Resolve Requirements File
    ${target_suite}=    Resolve Target Suite

    ${install}=    Run Process    ${PYTHON_CMD}    -m    pip    install    -r    ${requirements_file}    cwd=${EXECDIR}
    Should Be Equal As Integers    ${install.rc}    0    msg=Dependency install failed. STDOUT: ${install.stdout} STDERR: ${install.stderr}

    ${result}=    Run Process    browserstack-sdk    robot    ${target_suite}    cwd=${EXECDIR}
    Should Be Equal As Integers    ${result.rc}    0    msg=BrowserStack SDK run failed. STDOUT: ${result.stdout} STDERR: ${result.stderr}
    Log    ${result.stdout}

*** Keywords ***
Resolve Requirements File
    ${path}=    Evaluate    next((p for p in [r'''${CURDIR}${/}requirements.txt''', r'''${CURDIR}${/}..${/}requirements.txt''', r'''${EXECDIR}${/}requirements.txt''', r'''${EXECDIR}${/}..${/}requirements.txt'''] if os.path.isfile(p)), None)    os
    Should Not Be Equal    ${path}    ${None}    msg=requirements.txt not found in expected locations from CURDIR/EXECDIR.
    RETURN    ${path}

Resolve Target Suite
    ${path}=    Evaluate    next((p for p in [r'''${CURDIR}${/}${TARGET_SUITE_REL}''', r'''${CURDIR}${/}..${/}${TARGET_SUITE_REL}''', r'''${EXECDIR}${/}${TARGET_SUITE_REL}''', r'''${EXECDIR}${/}..${/}${TARGET_SUITE_REL}'''] if os.path.isfile(p)), None)    os
    Should Not Be Equal    ${path}    ${None}    msg=Target suite not found: ${TARGET_SUITE_REL}
    RETURN    ${path}
