*** Settings ***
Library      FilesOperationLibrary

*** Variables ***
${path}     ${CURDIR}/test_for_xls.xls
${path_new}     ${CURDIR}/test_for_xls_new.xls
${sheet}    test
${sheet_new}    test_new
${value}    new

*** Test Cases ***
test_read_excel_cell
    ${result1}=     read_excel_cell    ${path}     ${sheet}    1    1
    should_be_equal    ${result1}    old
test_modify_exist_excel_exist_sheet
    modify_excel_cell    ${path}     ${sheet}    0    1    ${value}
    ${result2}=     read_excel_cell    ${path}     ${sheet}    0    1
    should_be_equal    ${result2}    new
test_modify_exist_excel_not_exist_sheet
    modify_excel_cell    ${path}     ${sheet_new}    0    1    ${value}
    ${result3}=     read_excel_cell    ${path}     ${sheet_new}    0    1
    should_be_equal    ${result3}    new
test_modify_not_exist_excel
    modify_excel_cell    ${path_new}     ${sheet_new}    0    1    ${value}
    ${result4}=     read_excel_cell    ${path_new}     ${sheet_new}    0    1
    should_be_equal    ${result4}    new
