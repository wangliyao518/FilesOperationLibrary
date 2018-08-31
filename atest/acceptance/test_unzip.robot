*** Settings ***
Library      FilesOperationLibrary

*** Variables ***
${file1}     ${CURDIR}/snapshot.zip
${path1}     ${CURDIR}/snapshot/
${file2}     ${CURDIR}/pm.zip
${path2}     ${CURDIR}/unzip_pm/
${file3}     ${CURDIR}/messages.1.gz
${path3}     ${CURDIR}/gz/
${file4}     ${CURDIR}/BTS9_1011_dumps.tar
${path4}     ${CURDIR}/tar/
${file5}     ${CURDIR}/PM.BTS-1.20171129.024500.LTE.raw.xz
${path5}     ${CURDIR}/xz/
*** Test Cases ***
test_unzip_snapshot
    unzip_file    ${file1}     ${path1}
test_unzip_pm_to_path_is_none
    unzip_file    ${file2}
test_unzip_gz
    unzip_file    ${file3}     ${path3}
test_unzip_tar
    unzip_file    ${file4}     ${path4}
test_xz_tar
    unzip_file    ${file5}     ${path5}