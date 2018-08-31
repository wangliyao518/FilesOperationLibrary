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

    xml = StringIO.StringIO("""<?xml version="1.0" encoding="UTF-8"?>
        <example>
            <first id="1">text</first>
            <second id="2">
                <child/>
            </second>
            <third>
                <child>more text</child>
                <second id="child"/>
                <child><grandchild/></child>
                <another>ok</another>
                <another>SUCCESS</another>
                <another>200</another>
                <another>0000</another>
            </third>
            <html>
                <p>
                    Text with <b>bold</b> and <i>italics</i>
                </p>
            </html>
        </example>
		""")

    def setUp(self):
        self.xml_operator = XmlHandler()
        self.xml_operator.setup(self.xml, self.xml)

    def tearDown(self):
        #self.xml_operator.teardown()
        pass
    
    def test_modify_node_text(self):
        #self.xml_operator.modify_node_text('.//managedObject[@class="LNBTS"]/p[@name="actDLCAggr"]:false')
        pass

if __name__ == "__main__":
    unittest.main()
