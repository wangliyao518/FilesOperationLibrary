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
    modify_xml_text     .//managedObject[@className\="TEST:dd"][@funName\="TOPBTS-1/L2BTS-1/LNCEL-2/dd-0"]/p[@name\="applyOutOfSyncState"]:edddThree\
    ...                .//managedObject[@className\="TEST:L2BTS"]/list[@name\="amRlcPBTab2"]/item/p[@name\="ueCategory"]:1000\
    ...                .//managedObject[@className\="LNBTS"]/list[@name\="amRlcPBTab2"]/item/p[@name\="dlPollByte"]:56kB \
    ...                .//managedObject[@className\="CRGPR"]/list[@name\="plmnGroupList"]/item[1]/p[@name\="plmnGroupId"]:9
    [teardown]    teardown_xml

_est_modify_cell_node__example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_3.xml
    modify_xml_text     .//managedObject[@className\="LNCEL"]/p[@name\="prachFreqOff"]:80
    modify_xml_text     .//managedObject[@className\="LNCEL"][@distName\="MRBTS-1/LNBTS-1/LNCEL-2"]/p[@name\="prachHsFlag"]:true
    modify_xml_text     .//managedObject[@className\="LNCEL"][@distName\="0"]/p[@name\="prachPwrRamp"]:8dB
    modify_xml_text     .//managedObject[@className\="LNCEL"][@distName\="1"]/p[@name\="prachPwrRamp"]:8dB
    modify_xml_text     .//managedObject[@className\="LNBTS"]/list[@name\="rlcProf101"]/item/p[@name\="rlcProfileId"]:333    .//managedObject[@className\="LNBTS"]/list[@name\="rlcProf102"]/item/p[@name\="snFieldLengthDL"]:50bit \
    ...                  .//managedObject[@className\="LNBTS"]/list[@name\="qciTab1"]/item/p[@name\="maxGbrDl"]:300      
    [teardown]    teardown_xml
    
_est_add_xml4test_node_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_4.xml
    add_xml_node    .//managedObject[@className\="LNBTS"]/list[@name\="qciTab6"]/item:<p name\="nbrUl">10240</p>
	run keyword and ignore error    delete_xml_node    .//managedObject[@className\="LNBTS"]/list[@name\="qciTab5"]/item/p[@name\="nbrDl"]
	add_xml_node    .//managedObject[@className\="LNBTS"]/list[@name\="qciTab5"]/item:<p name\="nbrDl">2046</p>
    [teardown]    teardown_xml

_est_delete_xml4test_node_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_5.xml
    delete_xml_node    .//managedObject[@className\="LNCEL"][@distName\="0"]/list/item/p[@name\="dFpucchF1b"]
    [teardown]    teardown_xml

_est_get_xml4test_node_text_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_6.xml
    @{value}=     read_xml_text    .//managedObject[@className\="LNCEL"][@distName\="0"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal    @{value}[0]    1
    @{all_value}=    read_xml_text    .//managedObject[@className\="LNCEL"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal     @{all_value}[0]    1
    should_be_equal     @{all_value}[1]    1
    [teardown]    teardown_xml

_est_modify_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/xml4test.xml    save_path=${CURDIR}/xml4test_7.xml
    modify_xml_attribute        .//managedObject[@className\="LNCEL"]:@version\=TL16A:1
    [teardown]    teardown_xml

_est_get_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/xml4test.xml
    @{all_value}=    read_xml_attribute        .//managedObject[@className\="LNCEL"]:@version
    should_be_equal    @{all_value}[0]    TL16A
    should_be_equal    @{all_value}[1]    TL16A
    [teardown]    teardown_xml
