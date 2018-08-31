*** Settings ***
Library      FilesOperationLibrary

*** Variables ***
${path}    ${CURDIR}/TM7_P_30.csv
${title1}   DL-SCH Throughput(Kbps)
${title2}   SNR

*** Test Cases ***
test_read_csv_single_column
    @{value1}=     read_csv_columns    ${path}     ${title1}
    ${value}=    convert_to_string    @{value1}[2]
    should_be_equal    ${value}    27429.0560748

test_read_csv_m_columns
    @{value2}=     read_csv_columns    ${path}     ${title1}    ${title2}
    ${value}=    convert_to_string    @{value2}[0]
    should_be_equal    ${value}    [32413.4074074, 29903.1553398, 27429.0560748, 24605.4190476, 20259.5047619, 14786.4059406, 9866.125, 5094.38235294]
    ${value}=    convert_to_string    @{value2}[1]
    should_be_equal    ${value}    [28, 24, 20, 16, 12, 8, 4, 0]
