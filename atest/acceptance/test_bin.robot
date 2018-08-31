*** Settings ***
Library      FilesOperationLibrary

*** Variables ***
${path}     ${CURDIR}/LT-N1-DL8DSP_HD406900.BIN
${tag}      SwVersion
${new_value}    A406926

*** Test Cases ***
test_read_bin_file
    ${result1}=     read_bin_file    ${path}     ${tag}
    should_be_equal    ${result1}    D406900
test_modify_bin_file
    modify_bin_file    ${path}     ${tag}    ${new_value}
    ${result2}=     read_bin_file    ${path}     ${tag}
    should_be_equal    ${result2}    A406926


