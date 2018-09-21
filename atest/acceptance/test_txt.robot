*** Settings ***
Library      FilesOperationLibrary

*** Test Cases ***

test_modify_txt_node_one_argument_and_not_change_name_example
    setup_txt    src_file=${CURDIR}/profile.txt
    modify_txt_node        0x100410:1
    [teardown]    teardown_txt

test_modify_txt_node_one_argument_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_1.txt    alias = "test"
    modify_txt_node        0x140021:0xddd5dddd
    [teardown]    teardown_txt    alias = "test"
    
test_modify_txt_node_many_argument_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_2.txt
    modify_txt_node     0x14001f:0       0x1a1020:0x80400805
    [teardown]    teardown_txt

test_modify_txt_node_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_3.txt
    modify_txt_node     245:3
    modify_txt_node     249:4
    modify_txt_node     0x341000:5       0x121005:6
    [teardown]    teardown_txt

test_modify_txt_node_no_space_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_4.txt
    modify_txt_node     0x113001:0
    [teardown]    teardown_txt
    
test_add_txt_node_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_5.txt
    add_txt_node    0x010042:1# for debug
    add_txt_node    0x00130021:2
    [teardown]    teardown_txt

test_add_txt_node_when_no_cr__in_the_end_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile__no_cr_1.txt
    add_txt_node    0x010042:1# for debug
    add_txt_node    0x00130021:2
    [teardown]    teardown_txt

test_delete_txt_node_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_6.txt
    delete_txt_node    0x1e1084 = 6
    delete_txt_node    0x152003
    [teardown]    teardown_txt

test_read_txt_node_example
    setup_txt    src_file=${CURDIR}/profile.txt    save_path=${CURDIR}/profile_7.txt
    ${result1}=     read_txt_node    0x113001
    should_be_equal    ${result1}    0
    ${result2}=     read_txt_node    0x10049
    should_be_equal    ${result2}    NOT_FOUND
    [teardown]    teardown_txt

