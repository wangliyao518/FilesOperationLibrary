# -*- coding: utf-8 -*-
"""
:created on: 2018/8/28

:copyright: 
:author: leo
:contact: 
"""
import unittest
import os
import FtpLibrary
from FilesOperationLibrary.exception import TAFileException
from FilesOperationLibrary.interface import OperateXml
from FilesOperationLibrary.interface import OperateTxt
from FilesOperationLibrary.interface import FtpUploadDownload
from FilesOperationLibrary.interface import OperateCsv
from FilesOperationLibrary.interface import OperateBin
from FilesOperationLibrary.interface import OperateXls
from FilesOperationLibrary.interface import UnzipFile
from FilesOperationLibrary.interface import OperateLog
from mock import patch, PropertyMock, Mock

BASE_NAME = os.path.dirname(__file__)


class TestKissFilesInterfaceSCFC(unittest.TestCase):
    def setUp(self):
        self.xml_operator = OperateXml()

    def tearDown(self):
        pass

    def test__setup_and_teardown_scfc(self):
        self.xml_operator.setup_xml(os.path.join(BASE_NAME, 'SCFC_QT_FSIH.xml'))
        self.xml_operator.teardown_xml()

        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "SCFC_QT_FSIH.xml"),
                                    os.path.join(BASE_NAME, "SCFC_QT_FSIH_test.xml"))
        self.xml_operator.teardown_xml()

        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "SCFC_QT_FSIH.xml"),
                                    os.path.join(BASE_NAME, "SCFC_QT_FSIH_test1.xml"),
                                    alias='test')
        self.xml_operator.teardown_xml(alias='test')

    def test__modify_scfc_text(self):
        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "SCFC_QT_FSIH.xml"),
                                    os.path.join(BASE_NAME, "SCFC_QT_FSIH_test2.xml"))

        self.xml_operator.modify_xml_text('.//managedObject[@class="LNBTS"]/p[@name="actAutoAcBarring"]:true',
                                          './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab1"]/item/p[@name="dlPollByte"]:36kB')
        self.xml_operator.modify_xml_text(
            './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab2"]/item/p[@name="dlPollByte"]:56kB')
        result = self.xml_operator.read_xml_text('.//managedObject[@class="LNBTS"]/p[@name="actAutoAcBarring"]')[0]
        self.assertEqual(result, 'true')
        result = self.xml_operator.read_xml_text(
            './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab1"]/item/p[@name="dlPollByte"]')[0]
        self.assertEqual(result, '36kB')
        result = self.xml_operator.read_xml_text(
            './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab2"]/item/p[@name="dlPollByte"]')[0]
        self.assertEqual(result, '56kB')

        self.xml_operator.teardown_xml()

    def test__read_PM_text(self):
        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "PM.xml"))

        result = self.xml_operator.read_xml_text("//*[text()='PLMN-PLMN/MRBTS-1/LNBTS-1/LNCEL-1']/../..//M8001C500")[0]
        self.assertEqual(result, '1540')

        self.xml_operator.teardown_xml()

    def test__modify_scfc_attribute(self):
        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "SCFC_QT_FSIH.xml"),
                                    os.path.join(BASE_NAME, "SCFC_QT_FSIH_test3.xml"))

        self.xml_operator.modify_xml_attribute('.//managedObject[@class="LNBTS"]:@version=TL15B',
                                               './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab1"]/item/p[1]:@name=NewName')
        result = self.xml_operator.read_xml_attribute('.//managedObject[@class="LNBTS"]:@version')
        self.assertEqual(result[0], 'TL15B')
        result = self.xml_operator.read_xml_attribute(
            './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab1"]/item/p[1]:@name')
        self.assertEqual(result[0], 'NewName')
        result = self.xml_operator.read_xml_attribute(
            './/managedObject[@class="LNBTS"]/list[@name="amRlcPBTab1"]/item/p[2]:@name')
        self.assertEqual(result[0], 'ueCategory')

        self.xml_operator.teardown_xml()

    def test__add_scfc_node(self):
        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "SCFC_QT_FSIH.xml"),
                                    os.path.join(BASE_NAME, "SCFC_QT_FSIH_test4.xml"))

        self.xml_operator.add_xml_node(
            './/managedObject[@class="LNBTS"]/list[@name="qciTab6"]/item:<p name="nbrUl">10240</p>',
            './/managedObject[@class="LNBTS"]/list[@name="qciTab5"]/item:<p name="nbrDl">2046</p>')
        result = self.xml_operator.read_xml_text(
            './/managedObject[@class="LNBTS"]/list[@name="qciTab6"]/item/p[@name="nbrUl"]')[
            0]
        self.assertEqual(result, "10240")
        result = self.xml_operator.read_xml_text(
            './/managedObject[@class="LNBTS"]/list[@name="qciTab5"]/item/p[@name="nbrDl"]')[
            0]
        self.assertEqual(result, "2046")

        self.xml_operator.teardown_xml()

    def test__delete_scfc_node(self):
        self.xml_operator.setup_xml(os.path.join(BASE_NAME, "SCFC_QT_FSIH.xml"),
                                    os.path.join(BASE_NAME, "SCFC_QT_FSIH_test5.xml"))

        self.xml_operator.delete_xml_node(
            './/managedObject[@class="LNCEL"][@distName="0"]/list/item/p[@name="dFpucchF1b"]')

        try:
            self.xml_operator.read_xml_text(
                './/managedObject[@class="LNCEL"][@distName="0"]/list/item/p[@name="dFpucchF1b"]')[0]
        except TAFileException:
            self.assertTrue(True)
        else:
            self.assertTrue(False)
        finally:
            self.xml_operator.teardown_xml()



class TestKissFilesInterfaceTXT(unittest.TestCase):
    def setUp(self):
        self.txt_operator = OperateTxt()

    def tearDown(self):
        pass

    def test__setup_and_teardown_txt(self):
        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"))
        self.txt_operator.teardown_txt()

        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"),
                                    os.path.join(BASE_NAME, "swconfig_test.txt"))
        self.txt_operator.teardown_txt()

        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"),
                                    os.path.join(BASE_NAME, "swconfig_test1.txt"),
                                    alias='test')
        self.txt_operator.teardown_txt(alias='test')

    def test__get_txt_node(self):
        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"))

        self.assertEqual(self.txt_operator.read_txt_node('0x410000'), "1")
        self.assertEqual(self.txt_operator.read_txt_node('0x10041'), "5")
        self.assertEqual(self.txt_operator.read_txt_node('0x1e0084'), "6")

        self.txt_operator.teardown_txt()

    def test__modify_txt_node(self):
        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"),
                                    os.path.join(BASE_NAME, "swconfig_test2.txt"))

        self.txt_operator.modify_txt_node('0xf0011:2', '0x110001:1')
        self.txt_operator.modify_txt_node('0xa0154:0xddddd5d5')
        self.assertEqual(self.txt_operator.read_txt_node('0xf0011'), '2')
        self.assertEqual(self.txt_operator.read_txt_node('0x110001'), '1')
        self.assertEqual(self.txt_operator.read_txt_node('0xa0154'), '0xddddd5d5')

        self.txt_operator.teardown_txt()

    def test__add_txt_node(self):
        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"),
                                    os.path.join(BASE_NAME, "swconfig_test3.txt"))

        self.txt_operator.add_txt_node('0x010042:1#debug')
        self.assertEqual(self.txt_operator.read_txt_node('0x010042'), "1")

        self.txt_operator.add_txt_node('0x010044:1')
        self.assertEqual(self.txt_operator.read_txt_node('0x010042'), "1")

        self.txt_operator.add_txt_node('test:1:2')
        self.assertEqual(self.txt_operator.read_txt_node('test'), "1:2")

        self.txt_operator.teardown_txt()

    def test__delete_txt_node(self):
        self.txt_operator.setup_txt(os.path.join(BASE_NAME, "swconfig.txt"),
                                    os.path.join(BASE_NAME, "swconfig_test4.txt"))

        self.txt_operator.delete_txt_node('245', '249')
        self.assertEqual(self.txt_operator.read_txt_node('245'), 'NOT_FOUND')
        self.assertEqual(self.txt_operator.read_txt_node('249'), 'NOT_FOUND')

        self.txt_operator.teardown_txt()


class TestFtpDownloadUpload(unittest.TestCase):
    def setUp(self):
        self.ftp_operator = FtpUploadDownload()
        self._host = '192.168.255.1'
        self._port1 = 21
        self._port2 = 22
        self._user = 'toor4nsn'
        self._pwd = 'oZPS0POrRieRtu'

    def tearDown(self):
        pass

    @patch("FilesOperationLibrary.interface.FtpHandler.close_ftp")
    @patch("FtpLibrary.download_file")
    @patch("FilesOperationLibrary.interface.FtpHandler.connect_ftp")
    def test__ftp_download_file(self, mock_connect, mock_download, mock_close):
        self.ftp_operator.ftp_download(self._host, self._port1, self._user, self._pwd,
                                       '/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'config1/rat_ut.xml'))
        FtpLibrary.download_file.assert_called_with('/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'config1/rat_ut.xml'))

        self.ftp_operator.ftp_download(self._host, self._port1, self._user, self._pwd,
                                       '/tmp/rat_psconfig.xml', '{}/config1/'.format(BASE_NAME))
        FtpLibrary.download_file.assert_called_with('/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'config1//rat_psconfig.xml'))

        self.ftp_operator.ftp_download(self._host, self._port1, self._user, self._pwd,
                                       '/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'rat_psconfig1.xml'))
        FtpLibrary.download_file.assert_called_with('/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'rat_psconfig1.xml'))

        self.ftp_operator.ftp_download(self._host, self._port1, self._user, self._pwd, '/tmp/rat_psconfig.xml',
                                       os.path.join(BASE_NAME, 'rat_psconfig.xml'))
        FtpLibrary.download_file.assert_called_with('/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'rat_psconfig.xml'))

        self.ftp_operator.ftp_handler.close_ftp.assert_called_with()

    @patch("FilesOperationLibrary.interface.FtpHandler.close_ftp")
    @patch("FtpLibrary.upload_file")
    @patch("FtpLibrary.mkd")
    @patch("FtpLibrary.cwd")
    @patch("FtpLibrary.pwd")
    @patch("FilesOperationLibrary.interface.FtpHandler.connect_ftp")
    def test__ftp_upload_file(self, mock_connect, mock_pwd, mock_cwd, mock_mkd, mock_upload, mock_close):
        mock_pwd.return_value = '/tmp1'
        self.ftp_operator.ftp_upload(self._host, self._port1, self._user, self._pwd,
                                     os.path.join(BASE_NAME, 'config1/rat_ut.xml'), '/tmp/rat_psconfig_ut1.xml')
        FtpLibrary.upload_file.assert_called_with(os.path.join(BASE_NAME, 'config1/rat_ut.xml'), '/tmp/rat_psconfig_ut1.xml')

        self.ftp_operator.ftp_upload(self._host, self._port1, self._user, self._pwd,
                                     os.path.join(BASE_NAME, 'config1/rat_ut.xml'), '/tmp/')
        FtpLibrary.upload_file.assert_called_with(os.path.join(BASE_NAME, 'config1/rat_ut.xml'), '/tmp/rat_ut.xml')

        self.ftp_operator.ftp_upload(self._host, self._port1, self._user, self._pwd, os.path.join(BASE_NAME, 'config1/rat_ut.xml'), 'rat_ut1.xml')
        FtpLibrary.upload_file.assert_called_with(os.path.join(BASE_NAME, 'config1/rat_ut.xml'), '/tmp1/rat_ut1.xml')

        self.ftp_operator.ftp_upload(self._host, self._port1, self._user, self._pwd, os.path.join(BASE_NAME, 'config1/rat_ut.xml'))
        FtpLibrary.upload_file.assert_called_with(os.path.join(BASE_NAME, 'config1/rat_ut.xml'), '/tmp1')

        self.ftp_operator.ftp_handler.close_ftp.assert_called_with()

    @patch("pysftp.Connection")
    def test__sftp_download_file(self, mock_connect):
        self.ftp_operator.sftp_download(self._host, self._port2, self._user, self._pwd,
                                        '/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'config2/rat_ut.xml'))
        self.ftp_operator.sftp_download(self._host, self._port2, self._user, self._pwd,
                                        '/tmp/rat_psconfig.xml', '{}/config2/'.format(BASE_NAME))
        self.ftp_operator.sftp_download(self._host, self._port2, self._user, self._pwd,
                                        '/tmp/rat_psconfig.xml', os.path.join(BASE_NAME, 'rat_ut.xml'))
        self.ftp_operator.sftp_download(self._host, self._port2, self._user, self._pwd,
                                        '/tmp/rat_psconfig.xml')
        self.ftp_operator.sftp_download(self._host, self._port2, self._user, self._pwd,
                                        '/tmp/', '{}/'.format(BASE_NAME))
        self.ftp_operator.sftp_download(self._host, self._port2, self._user, self._pwd,
                                        '/tmp/')

    @patch("pysftp.Connection")
    def test__sftp_upload_file(self, mock_connect):
        self.ftp_operator.sftp_upload(self._host, self._port2, self._user, self._pwd,
                                      os.path.join(BASE_NAME, 'config2/rat_ut.xml'), '/tmp/rat_psconfig_ut2.xml')
        # self.ftp_operator.sftp_upload(self._host, self._port2, self._user, self._pwd,
        #                               os.path.join(BASE_NAME, 'config2/rat_ut.xml'), '/tmp/')
        # self.ftp_operator.sftp_upload(self._host, self._port2, self._user, self._pwd,
        #                               os.path.join(BASE_NAME, 'config2/rat_ut.xml'),
        #                               os.path.join(BASE_NAME, 'rat_psconfig_ut2.xml'))

    @patch("FilesOperationLibrary.interface.SFtpHandler.sftp_download_latest_file")
    def test__sftp_download_latest_file(self, mock_sftp):
        self.ftp_operator.download_latest_file(self._host, self._port2, self._user, self._pwd,
                                               '/tmp/log/', '{}/'.format(BASE_NAME), filter='PM.*.xml')
        self.ftp_operator.download_latest_file(self._host, self._port2, self._user, self._pwd,
                                               '/tmp/log/', filter='PM.*.xml')


class TestKissFilesInterfaceCSV(unittest.TestCase):
    def setUp(self):
        self.csv_operator = OperateCsv()

    def tearDown(self):
        pass

    def test__read_csv_columns(self):
        self.assertEqual(self.csv_operator.read_csv_columns(os.path.join(BASE_NAME, "TM7_P_30.csv"), "SNR")[-1], 0)
        self.assertEqual(
            self.csv_operator.read_csv_columns(os.path.join(BASE_NAME, "TM7_P_30.csv"), "SNR", "Wideband CQI 1")[1][2],
            12.4901079137)


class TestKissFilesInterfaceBIN(unittest.TestCase):
    def setUp(self):
        self.bin_operator = OperateBin()
        self.file = open(os.path.join(BASE_NAME, "LT-N1-DL8DSP_HD406900.BIN"), 'r+b')

    def tearDown(self):
        pass

    def test__read_bin_file(self):
        self.assertEqual(
            self.bin_operator.read_bin_file(os.path.join(BASE_NAME, "LT-N1-DL8DSP_HD406900.BIN"), "SwVersion"),
            'D406900')
        self.assertEqual(
            self.bin_operator.read_bin_file(os.path.join(BASE_NAME, "LT-N1-DL8DSP_HD406900.BIN"), "HwVersion"),
            'NOT FOUND')

    def test__modify_bin_file(self):
        self.bin_operator.modify_bin_file(os.path.join(BASE_NAME, "LT-N1-DL8DSP_HD406900.BIN"), "TargetUnit", "FSMF")
        self.assertEqual(
            self.bin_operator.read_bin_file(os.path.join(BASE_NAME, "LT-N1-DL8DSP_HD406900.BIN"), "TargetUnit"),
            'FSMF')
        self.assertEqual(
            self.bin_operator.modify_bin_file(os.path.join(BASE_NAME, "LT-N1-DL8DSP_HD406900.BIN"), "TargetUnit", "FSPMF"),
            'Fail to modify')


class TestKissFilesInterfaceXLS(unittest.TestCase):
    def setUp(self):
        self.xls_operator = OperateXls()

    def tearDown(self):
        pass

    def test__read_excel_cell(self):
        self.assertEqual(self.xls_operator.read_excel_cell(os.path.join(BASE_NAME, "test_for_xls.xls"), "test", 1, 1), "old")

    def test__modify_excel_cell(self):
        self.xls_operator.modify_excel_cell(os.path.join(BASE_NAME, "test_for_xls.xls"), "test", 1, 0, "new")
        self.assertEqual(self.xls_operator.read_excel_cell(os.path.join(BASE_NAME, "test_for_xls.xls"), "test", 1, 0), "new")

        self.xls_operator.modify_excel_cell(os.path.join(BASE_NAME, "test_for_xls_new.xls"), "new", 0, 1, "new")
        self.assertEqual(self.xls_operator.read_excel_cell(os.path.join(BASE_NAME, "test_for_xls_new.xls"), "new", 0, 1), "new")


class TestKissFilesInterfaceUnzip(unittest.TestCase):
    def setUp(self):
        self.unzip_operator = UnzipFile()

    def tearDown(self):
        pass

    def test__unzip_file(self):
        os.system = Mock()
        self.unzip_operator.unzip_file(os.path.join(BASE_NAME, "snapshot.zip"))
        self.unzip_operator.unzip_file(os.path.join(BASE_NAME, "snapshot.zip"), "./")
        self.unzip_operator.unzip_file(os.path.join(BASE_NAME, "test.tar.gz"))


class TestKissFilesInterfaceLOG(unittest.TestCase):
    def setUp(self):
        self.log_operator = OperateLog()
        pass

    def test__unzip_file(self):
        self.log_operator.split_iphy_log_by_ueid(os.path.join(BASE_NAME, "rrc.log"))
        self.log_operator.split_iphy_log_by_ueid(os.path.join(BASE_NAME, "rrc_UErelease.log"))


if __name__ == "__main__":
    unittest.main()
