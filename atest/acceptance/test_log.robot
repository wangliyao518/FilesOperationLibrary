*** Settings ***
Library      FilesOperationLibrary

*** Test Cases ***
test_split_iphy_log_by_ueid
    split_iphy_log_by_ueid    ${CURDIR}/rrc.log
    split_iphy_log_by_ueid    ${CURDIR}/rrc_UErelease.log

test file should contain
    ${ret}   file should contain       ${CURDIR}/rrc.log       tdd-AckNackFeedbackMode
    ${check_list}     create list       tdd-AckNackFeedbackMode       rrcConnectionSetupComplete-r8
    ${ret}   file should contain       ${CURDIR}/rrc.log      ${check_list}

test file should not contain
    ${ret}   file should not contain       ${CURDIR}/rrc.log       UExxxxxx
   
test file match all 
    ${ret}   file match all      ${CURDIR}/rrc.log       UEC-\\d+