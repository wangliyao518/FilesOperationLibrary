*** Settings ***
Library      FilesOperationLibrary


*** Test Cases ***

test_modify_bts_node_one_argument_and_not_change_name_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml
    modify_xml_text        .//managedObject[@class\="NOKLTE:LNBTS"]/p[@name\="actAutoAcBarring"]:true
    [teardown]    teardown_xml

test_modify_bts_node_one_argument_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_1.xml
    modify_xml_text        .//managedObject[@class\="NOKLTE:LNBTS"]/p[@name\="actDLCAggr"]:false
    [teardown]    teardown_xml
    
test_modify_node_many_argument_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_2.xml
    modify_xml_text     .//managedObject[@class\="NOKLTE:LNBTS"]/p[@name\="actDLCAggr"]:false    .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="amRlcPBTab1"]/item/p[@name\="dlPollByte"]:36kB    .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="amRlcPBTab2"]/item/p[@name\="dlPollByte"]:56kB \
    ...                 .//managedObject[@class\="NOKLTE:SDRX"]/list[@name\="drxSmartProfile2"]/item[1]/p[@name\="drxInactivityT"]:9
    [teardown]    teardown_xml

test_modify_cell_node__example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_3.xml
    modify_xml_text     .//managedObject[@class\="NOKLTE:LNCEL_TDD"]/p[@name\="act1TxIn2Tx"]:true
    modify_xml_text     .//managedObject[@class\="NOKLTE:LNCEL_TDD"][@distName\="MRBTS-1/LNBTS-1/LNCEL-3/LNCEL_TDD-0"]/p[@name\="prachHsFlag"]:true
    modify_xml_text     .//managedObject[@class\="NOKLTE:LNCEL_TDD"][@distName\="0"]/p[@name\="filterCoefficientPccpchRscp"]:fc5
    modify_xml_text     .//managedObject[@class\="NOKLTE:LNCEL_TDD"][@distName\="1"]/p[@name\="filterCoefficientPccpchRscp"]:fc6
    modify_xml_text     .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="rlcProf101"]/item/p[@name\="rlcProfileId"]:333    .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="rlcProf102"]/item/p[@name\="snFieldLengthDL"]:50bit \
    ...                  .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="qciTab1"]/item/p[@name\="maxGbrDl"]:300      
    [teardown]    teardown_xml
    
test_add_scfc_node_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_4.xml
    add_xml_node    .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="qciTab6"]/item:<p name\="nbrUl">10240</p>
    run keyword and ignore error    delete_xml_node    .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="qciTab5"]/item/p[@name\="nbrDl"]
    add_xml_node    .//managedObject[@class\="NOKLTE:LNBTS"]/list[@name\="qciTab5"]/item:<p name\="nbrDl">2046</p>
    [teardown]    teardown_xml

test_delete_scfc_node_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_5.xml
    delete_xml_node    .//managedObject[@class\="NOKLTE:LNMME"][@distName\="MRBTS-1/LNBTS-1/LNMME-0"]/list/item/p[@name\="mncLength"]
    [teardown]    teardown_xml

test_get_scfc_node_text_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_6.xml
    @{value}=     read_xml_text    .//managedObject[@class\="NOKLTE:LNMME"][@distName\="MRBTS-1/LNBTS-1/LNMME-0"]/list/item/p[@name\="mnc"]
    should_be_equal    @{value}[0]    3
    @{all_value}=    read_xml_text    .//managedObject[@class\="NOKLTE:LNCEL"]/list/item/p[@name\="dFpucchF1b"]
    should_be_equal     @{all_value}[0]    1
    should_be_equal     @{all_value}[1]    1
    [teardown]    teardown_xml

test_modify_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml    save_path=${CURDIR}/scfc_7.xml
    modify_xml_attribute        .//managedObject[@class\="NOKLTE:LNCEL_TDD"]:@version\=TL17_1610_01_1610_02
    [teardown]    teardown_xml

test_get_bts_node_attribute_one_argument_example
    setup_xml    src_file=${CURDIR}/SCFC_NOK_LNT_prefix.xml
    @{all_value}=    read_xml_attribute       .//managedObject[@class\="NOKLTE:LNCEL_TDD"]:@version
    should_be_equal    @{all_value}[0]    TL17_1610_01_1610_01
    should_be_equal    @{all_value}[1]    TL17_1610_01_1610_01
    [teardown]    teardown_xml

