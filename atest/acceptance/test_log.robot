*** Settings ***
Library      FilesOperationLibrary

*** Test Cases ***
test_split_iphy_log_by_ueid
    split_iphy_log_by_ueid    ${CURDIR}/message.log
    split_iphy_log_by_ueid    ${CURDIR}/rrc_UErelease.log

test file should contain
    ${ret}   file should contain       ${CURDIR}/message.log       tdd-AckNackFeedbackMode
    ${check_list}     create list       tdd-AckNackFeedbackMode       rrcConnectionSetupComplete-r8
    ${ret}   file should contain       ${CURDIR}/message.log      ${check_list}

test file should not contain
    ${ret}   file should not contain       ${CURDIR}/message.log       UExxxxxx
   
test file match all 
    ${ret}   file match all      ${CURDIR}/message.log       UEC-\\d+