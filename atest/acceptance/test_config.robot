*** Settings ***
Library      FilesOperationLibrary

*** Test Cases ***

test_modify_bts_node_one_argument_and_not_change_name_example
    setup_xml    src_file=${CURDIR}/config.xml
    modify_xml_text        .//managedObject[@class\="QOS"]/p[@name\="enablePhbCounters"]:true
    [teardown]    teardown_xml

test_modify_bts_node_one_argument_example
    setup_xml    src_file=${CURDIR}/config.xml    save_path=${CURDIR}/config_1.xml
    modify_xml_text        .//managedObject[@class\="QOS"]/p[@name\="sseDscpOverwrite"]:true
    [teardown]    teardown_xml
    
test_modify_node_many_argument_example
    setup_xml    src_file=${CURDIR}/config.xml    save_path=${CURDIR}/config_2.xml
    modify_xml_text     .//managedObject[@class\="UNIT"]/p[@name\="enableRP301Interface"]:true    .//managedObject[@class\="ETHLK"]/list[@name\="l2VlanIdList"]/item/p[@name\="lowValue"]:4    .//managedObject[@class\="ETHLK"]/list[@name\="l2VlanIdList"]/item/p[@name\="highValue"]:2048 \
    ...                 .//managedObject[@class\="L2SWI"]/list[@name\="dscpMap"]/item[1]/p[@name\="priorityQueue"]:9
    [teardown]    teardown_xml

test_modify_cell_node__example
    setup_xml    src_file=${CURDIR}/config.xml    save_path=${CURDIR}/config_3.xml
    modify_xml_text     .//managedObject[@class\="ETHLK"][@distName\="0"]/p[@name\="l2BurstSize"]:2
    modify_xml_text     .//managedObject[@class\="ETHLK"][@distName\="1"]/p[@name\="l2BurstSize"]:3
    modify_xml_text     .//managedObject[@class\="IPRT"]/list[@name\="staticRoutes"]/item/p[@name\="preference"]:3    .//managedObject[@class\="IPRT"]/list[@name\="staticRoutes"]/item/p[@name\="bfdId"]:5 \
    ...                  .//managedObject[@class\="TOPP"]/list[@name\="topMasters"]/item/p[@name\="masterIpAddr"]:1.1.1.1     
    [teardown]    teardown_xml
    
test_add_scfc_node_example
    setup_xml    src_file=${CURDIR}/config.xml    save_path=${CURDIR}/config_4.xml
    add_xml_node    .//managedObject[@class\="ETHLK"]/list[@name\="l2VlanIdList"]/item:<p name\="midvalue0">1024</p>
    add_xml_node    .//managedObject[@class\="ETHLK"]/list[@name\="l2VlanIdList"]/item:<p name\="midvalue1">1024</p>
    [teardown]    teardown_xml

test_delete_scfc_node_example
    setup_xml    src_file=${CURDIR}/config.xml    save_path=${CURDIR}/config_5.xml
    delete_xml_node    .//managedObject[@class\="ETHLK"][@distName\="0"]/list[@name\="l2VlanIdList"]/item/p[@name\="lowValue"]
    delete_xml_node    .//managedObject[@class\="ETHLK"][@distName\="1"]/list[@name\="l2VlanIdList"]/item
    [teardown]    teardown_xml

test_get_scfc_node_text_example
    setup_xml    src_file=${CURDIR}/config.xml    save_path=${CURDIR}/config_6.xml
    @{value}=     read_xml_text    .//managedObject[@class\="IPNO"]/p[@name\="servingOms"]
    should_be_equal    @{value}[0]    none
    @{all_value}=    read_xml_text    .//managedObject[@class\="ETHLK"]/list/item/p[@name\="lowValue"]
    should_be_equal     @{all_value}[0]    2
    should_be_equal     @{all_value}[1]    2
    [teardown]    teardown_xml

