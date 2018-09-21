*** Settings ***
Library      FilesOperationLibrary


*** Test Cases ***

test_modify_bts_node_one_argument_and_not_change_name_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_0.xml
    modify_xml_text        .//managedObject[@className\="TEST:dd"]/p[@name\="applyOutOfSyncState"]:edddOnly
    ${value}    read_xml_text          .//managedObject[@className\="TEST:dd"]/p[@name\="applyOutOfSyncState"]
    log to console    ${value}
    should_be_equal   @{value}[0]    edddOnly
    should_be_equal   @{value}[1]    edddOnly        
    [teardown]    teardown_xml

test_modify_bts_node_one_argument_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_1.xml
    modify_xml_text        .//managedObject[@className\="TEST:dd"][@funName\="0"]/p[@name\="applyOutOfSyncState"]:edddTwo
    ${value}    read_xml_text          .//managedObject[@className\="TEST:dd"][@funName\="0"]/p[@name\="applyOutOfSyncState"]
    log to console    ${value}
    should_be_equal   @{value}[0]    edddTwo
    [teardown]    teardown_xml
    
test_modify_node_many_argument_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_2.xml
    modify_xml_text     .//managedObject[@className\="TEST:dd"][@funName\="TOPBTS-1/L2BTS-1/LNCEL-2"]/p[@name\="applyOutOfSyncState"]:edddThree\
    ...                .//managedObject[@className\="TEST:L2BTS"]/list[@name\="amRlcPBTab2"]/item/p[@name\="ueCategory"]:1000\
    ...                .//managedObject[@className\="TEST:L2BTS"]/list[@name\="amRlcPBTab2"]/item/p[@name\="dlPollByte"]:56kB \
    [teardown]    teardown_xml

test_modify_cell_node__example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_3.xml
    modify_xml_text     .//managedObject[@className\="TEST:LNCEL"]/p[@name\="a1TimeToTriggerDeactiveInterMeas"]:80
    modify_xml_text     .//managedObject[@className\="TEST:LNCEL"][@funName\="TOPBTS-1/L2BTS-1/LNCEL-1"]/p[@name\="activeUlLnkAdp"]:dltest
    modify_xml_text     .//managedObject[@className\="TEST:LNCEL"][@funName\="0"]/p[@name\="activeUlpcMethod"]:PuschCLPucchDL
    modify_xml_text     .//managedObject[@className\="TEST:LNCEL"][@funName\="1"]/p[@name\="activeUlpcMethod"]:PuschCLPucchDL
    modify_xml_text     .//managedObject[@className\="TEST:L2BTS"]/list[@name\="pdcpProf101"]/item/p[@name\="pdcpProfileId"]:200 \
    ...                 .//managedObject[@className\="TEST:L2BTS"]/list[@name\="pdcpProf102"]/item/p[@name\="pdcpProfileId"]:300 \
    ...                 .//managedObject[@className\="TEST:L2BTS"]/list[@name\="qciTab1"]/item/p[@name\="delayTarget"]:300ms    
    [teardown]    teardown_xml
    
test_add_xml4test_node_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_4.xml
    add_xml_node    .//managedObject[@className\="TEST:L2BTS"]/list[@name\="qciTab1"]/item:<p name\="nbrUlTest">100000</p>
	run keyword and ignore error    delete_xml_node    .//managedObject[@className\="TEST:L2BTS"]/list[@name\="qciTab1"]/item/p[@name\="dscp"]
	add_xml_node    .//managedObject[@className\="TEST:L2BTS"]/list[@name\="qciTab1"]/item:<p name\="dscp">2046</p>
    [teardown]    teardown_xml

test_delete_xml4test_node_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_5.xml
    delete_xml_node    .//managedObject[@className\="TEST:LNCEL"][@funName\="0"]/list/item/p[@name\="dFpucchF2b"]
    [teardown]    teardown_xml

test_get_xml4test_node_text_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_6.xml
    @{value}=     read_xml_text    .//managedObject[@className\="TEST:LNCEL"][@funName\="0"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal    @{value}[0]    1
    @{all_value}=    read_xml_text    .//managedObject[@className\="TEST:LNCEL"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal     @{all_value}[0]    1
    should_be_equal     @{all_value}[1]    1
    [teardown]    teardown_xml

test_modify_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_7.xml
    modify_xml_attribute        .//managedObject[@className\="TEST:LNCEL"]:@version\=TL20180901:1
    [teardown]    teardown_xml

test_get_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/xml4test.xml
    @{all_value}=    read_xml_attribute        .//managedObject[@className\="TEST:LNCEL"]:@version
    should_be_equal    @{all_value}[0]    17A_1701_07_1701_06
    should_be_equal    @{all_value}[1]    17A_1701_07_1701_06
    [teardown]    teardown_xml
