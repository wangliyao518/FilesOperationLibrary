*** Settings ***
Library      FilesOperationLibrary


*** Test Cases ***

test_modify_bts_node_one_argument_and_not_change_name_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml
    modify_xml_text        .//managedObject[@class\="LNBTS"]/p[@name\="actAutoAcBarring"]:true
    [teardown]    teardown_xml

test_modify_bts_node_one_argument_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_1.xml
    modify_xml_text        .//managedObject[@class\="LNBTS"]/p[@name\="actDLCAggr"]:false
    [teardown]    teardown_xml
    
test_modify_node_many_argument_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_2.xml
    modify_xml_text     .//managedObject[@class\="LNBTS"]/p[@name\="actDLCAggr"]:false    .//managedObject[@class\="LNBTS"]/list[@name\="amRlcPBTab1"]/item/p[@name\="dlPollByte"]:36kB    .//managedObject[@class\="LNBTS"]/list[@name\="amRlcPBTab2"]/item/p[@name\="dlPollByte"]:56kB \
    ...                 .//managedObject[@class\="CRGPR"]/list[@name\="plmnGroupList"]/item[1]/p[@name\="plmnGroupId"]:9
    [teardown]    teardown_xml

test_modify_cell_node__example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_3.xml
    modify_xml_text     .//managedObject[@class\="LNCEL"]/p[@name\="prachFreqOff"]:80
    modify_xml_text     .//managedObject[@class\="LNCEL"][@distName\="MRBTS-1/LNBTS-1/LNCEL-2"]/p[@name\="prachHsFlag"]:true
    modify_xml_text     .//managedObject[@class\="LNCEL"][@distName\="0"]/p[@name\="prachPwrRamp"]:8dB
    modify_xml_text     .//managedObject[@class\="LNCEL"][@distName\="1"]/p[@name\="prachPwrRamp"]:8dB
    modify_xml_text     .//managedObject[@class\="LNBTS"]/list[@name\="rlcProf101"]/item/p[@name\="rlcProfileId"]:333    .//managedObject[@class\="LNBTS"]/list[@name\="rlcProf102"]/item/p[@name\="snFieldLengthDL"]:50bit \
    ...                  .//managedObject[@class\="LNBTS"]/list[@name\="qciTab1"]/item/p[@name\="maxGbrDl"]:300      
    [teardown]    teardown_xml
    
test_add_scfc_node_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_4.xml
    add_xml_node    .//managedObject[@class\="LNBTS"]/list[@name\="qciTab6"]/item:<p name\="nbrUl">10240</p>
	run keyword and ignore error    delete_xml_node    .//managedObject[@class\="LNBTS"]/list[@name\="qciTab5"]/item/p[@name\="nbrDl"]
	add_xml_node    .//managedObject[@class\="LNBTS"]/list[@name\="qciTab5"]/item:<p name\="nbrDl">2046</p>
    [teardown]    teardown_xml

test_delete_scfc_node_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_5.xml
    delete_xml_node    .//managedObject[@class\="LNCEL"][@distName\="0"]/list/item/p[@name\="dFpucchF1b"]
    [teardown]    teardown_xml

test_get_scfc_node_text_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_6.xml
    @{value}=     read_xml_text    .//managedObject[@class\="LNCEL"][@distName\="0"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal    @{value}[0]    1
    @{all_value}=    read_xml_text    .//managedObject[@class\="LNCEL"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal     @{all_value}[0]    1
    should_be_equal     @{all_value}[1]    1
    [teardown]    teardown_xml

test_modify_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml    save_path=${CURDIR}/scfc_7.xml
    modify_xml_attribute        .//managedObject[@class\="LNCEL"]:@version\=TL16A:1
    [teardown]    teardown_xml

test_get_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/scfc_0.xml
    @{all_value}=    read_xml_attribute        .//managedObject[@class\="LNCEL"]:@version
    should_be_equal    @{all_value}[0]    TL16A
    should_be_equal    @{all_value}[1]    TL16A
    [teardown]    teardown_xml
