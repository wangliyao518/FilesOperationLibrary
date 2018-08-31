*** Settings ***
Library      FilesOperationLibrary

*** Test Cases ***

test_modify_txt_node_one_argument_and_not_change_name_example
    setup_txt    src_file=${CURDIR}/swconfig.txt
    modify_txt_node        0x110003:1
    [teardown]    teardown_txt

test_modify_txt_node_one_argument_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_1.txt    alias = "test"
    modify_txt_node        0xa0156:0xddd5dddd
    [teardown]    teardown_txt    alias = "test"
    
test_modify_txt_node_many_argument_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_2.txt
    modify_txt_node     0x15001b:0       0x1e0148:0x80400805
    [teardown]    teardown_txt

test_modify_txt_node_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_3.txt
    modify_txt_node     245:3
    modify_txt_node     312:4
    modify_txt_node     0x340000:5       0x120006:6
    [teardown]    teardown_txt

test_modify_txt_node_no_space_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_4.txt
    modify_txt_node     0x410000:0
    [teardown]    teardown_txt
    
test_add_txt_node_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_5.txt
    add_txt_node    0x010042:1# for debug
    add_txt_node    0x00130021:2
    [teardown]    teardown_txt

test_add_txt_node_when_no_cr__in_the_end_example
    setup_txt    src_file=${CURDIR}/swconfig_no_cr.txt    save_path=${CURDIR}/swconfig__no_cr_1.txt
    add_txt_node    0x010042:1# for debug
    add_txt_node    0x00130021:2
    [teardown]    teardown_txt

test_delete_txt_node_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_6.txt
    delete_txt_node    0x340000    245
    delete_txt_node    0x10040
    [teardown]    teardown_txt

test_read_txt_node_example
    setup_txt    src_file=${CURDIR}/swconfig.txt    save_path=${CURDIR}/swconfig_7.txt
    ${result1}=     read_txt_node    0x10040
    should_be_equal    ${result1}    2
    ${result2}=     read_txt_node    0x10049
    should_be_equal    ${result2}    NOT_FOUND
    [teardown]    teardown_txt

