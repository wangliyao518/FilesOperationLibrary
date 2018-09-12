# -*- coding: utf-8 -*-
"""
:created on: 2018/8/28

:copyright: 
:author: leo
:contact: 
"""
import unittest
import os
from mock import patch, PropertyMock, Mock
from FilesOperationLibrary.handle_xml import XmlHandler
import StringIO
import lxml.etree

BASE_NAME = os.path.dirname(__file__)


class TestXmlHandler(unittest.TestCase):

    xml_data = """<?xml version="1.0" encoding="UTF-8"?>
                               <raml xmlns="raml21.xsd" version="2.1">
                               <cmData type="plan">
                               <header>
                               <log action="created" dateTime="2018-05-24T09:22:20"></log>
                               </header>
                               <managedObject class="com.company.srbts.mnl:CHANNEL" distName="MRBTS-1/MNL-1/MNLENT-1/CELLMAPPING-1/LCELL-13/CHANNELGROUP-1/CHANNEL-4" operation="create" version="17A_1701_07_1701_06">
                               <p name="antlDN">MRBTS-1/EQM-1/APEQM-1/RMOD-2/ANTL-11</p>
                               <p name="direction">RX</p>
                               </managedObject>
                               <managedObject class="company:SIB" distName="MRBTS-1/LNBTS-1/LNCEL-3/SIB-0" operation="create" version="17A_1701_07_1701_06">
                                <p name="barSkipForMMTEL">false</p>
                                <p name="bProfileId">1</p>
                                <list name="sib1Scheduling">
                                    <item>
                                    <p name="siMessagePeriodicity">160ms</p>
                                    <p name="siMessageRepetition">1</p>
                                    <p name="siMessageSibType">SIB1</p>
                                    </item>
                                </list>
                                <p name="sib2xTransmit">false</p>
                                <list name="sib2Scheduling">
                                    <item>
                                    <p name="siMessagePeriodicity">640ms</p>
                                    <p name="siMessageRepetition">1</p>
                                    </item>
                                </list>
                                <p name="t300">200ms</p>
                                </managedObject>
                               </cmData>
                               </raml>
		"""

    def setUp(self):
        self.xml = StringIO.StringIO(self.xml_data)
        self.xml_operator = XmlHandler()
        self.xml_operator.setup(self.xml, self.xml)

    def tearDown(self):
        #self.xml_operator.teardown()
        pass

    def test_get_node_text(self):
        text = self.xml_operator.get_node_text('.//managedObject[@class="com.company.srbts.mnl:CHANNEL"]/p[@name="direction"]')[0]
        self.assertEqual(text, 'RX')

    def test_modify_node_text(self):
        self.xml_operator.modify_node_text('.//managedObject[@class="com.company.srbts.mnl:CHANNEL"]/p[@name="direction"]:TX')
        text = self.xml_operator.get_node_text('.//managedObject[@class="com.company.srbts.mnl:CHANNEL"]/p[@name="direction"]')[0]
        self.assertEqual(text, 'TX')

    def test_get_node_attribute(self):
        version_value = self.xml_operator.get_node_attribute('.//managedObject[@class="company:SIB"]:@version')[0]
        self.assertEqual(version_value, '17A_1701_07_1701_06')

    def test_modify_node_attribute(self):
        pass
        #self.xml_operator.modify_node_attribute()

    def test_add_node(self):
        add_xml_node = """.//managedObject[@class="company:SIB"]:<list name="dlSectorBFWeightCusProf"><item>
           <p name="dlSectorBFWeightProfName">customized profile 1</p><p name="modulusOfWeighforAntGrp0">100</p>
           <p name="modulusOfWeighforAntGrp1">100</p><p name="modulusOfWeighforAntGrp2">200</p></item></list>"""
        self.xml_operator.add_node(add_xml_node)
        text_1 = self.xml_operator.get_node_text('.//managedObject[@class="company:SIB"]/list/item/p[@name="modulusOfWeighforAntGrp1"]')[0]
        text_2 = self.xml_operator.get_node_text('.//managedObject[@class="company:SIB"]/list/item/p[@name="modulusOfWeighforAntGrp2"]')[0]
        text_3 = self.xml_operator.get_node_text('.//managedObject[@class="company:SIB"]/list/item/p[@name="dlSectorBFWeightProfName"]')[0]
        self.assertEqual(text_1, '100')
        self.assertEqual(text_2, '200')
        self.assertEqual(text_3, 'customized profile 1')


if __name__ == "__main__":
    unittest.main()
