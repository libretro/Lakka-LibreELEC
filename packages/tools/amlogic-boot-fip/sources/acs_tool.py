# uncompyle6 version 3.2.4
# Python bytecode 2.7 (62211)
# Decompiled from: Python 3.6.7 (default, Nov  3 2018, 21:32:46)
# [GCC 8.2.0]
# Embedded file name: acs_tool.py
# Compiled at: 2015-09-17 07:30:19
import sys, os, os.path, json
from struct import *
import codecs, shutil, copy, collections
ENTRY_POINT_OFFSET = 4
BL2_HEADER_OFFSET = 4096
ACS_TOOL_VERSION = 1
acs_v1 = collections.OrderedDict()
acs_v1['acs_magic'] = 'acs__'
acs_v1['chip_type'] = 1
acs_v1['version'] = 2
acs_v1['acs_set_length'] = 8
acs_v1['ddr_magic'] = 'ddrs_'
acs_v1['ddr_set_version'] = 1
acs_v1['ddr_set_length'] = 2
acs_v1['ddr_set_addr'] = 8
acs_v1['ddrt_magic'] = 'ddrt_'
acs_v1['ddrt_set_version'] = 1
acs_v1['ddrt_set_length'] = 2
acs_v1['ddrt_set_addr'] = 8
acs_v1['pll_magic'] = 'pll__'
acs_v1['pll_set_version'] = 1
acs_v1['pll_set_length'] = 2
acs_v1['pll_set_addr'] = 8
check_excepts = [
 'ddr_set_addr', 'ddrt_set_addr', 'pll_set_addr']
check_excepts_length = ['ddr_set_length', 'ddrt_set_length', 'pll_set_length']
key_versions = ['version', 'ddr_set_version', 'ddrt_set_version', 'pll_set_version']

class acs_tool(object):

    def __init__(self, file_des, file_des_tmp, file_src, debug):
        self.debug = int(debug)
        self.file_des = file_des
        self.file_src = file_src
        self.file_des_tmp = file_des_tmp
        self.acs_des = copy.deepcopy(acs_v1)
        self.acs_src = copy.deepcopy(acs_v1)
        self.acs_base = copy.deepcopy(acs_v1)

    def init_acs(self, acs_struct, file_name, bl2):
        seek_position = 0
        file_handler = open(file_name, 'rb')
        file_handler.seek(ENTRY_POINT_OFFSET)
        acs_entry_point, = unpack('H', file_handler.read(2))
        acs_entry_point -= bl2 * BL2_HEADER_OFFSET
        seek_position = acs_entry_point
        self.log_print(file_name)
        for key in list(acs_struct.keys()):
            file_handler.seek(seek_position)
            if isinstance(acs_struct[key], str):
                seek_position += len(acs_struct[key])
                acs_struct[key] = file_handler.read(len(acs_struct[key])).decode('utf-8')
            else:
                if isinstance(acs_struct[key], int):
                    seek_position += acs_struct[key]
                    if 1 == acs_struct[key]:
                        acs_struct[key], = unpack('B', file_handler.read(1))
                    else:
                        acs_struct[key], = unpack('H', file_handler.read(2))
                    if key in check_excepts:
                        acs_struct[key] -= bl2 * BL2_HEADER_OFFSET
            self.log_print(key + ' ' + str(acs_struct[key]))

        file_handler.close()

    def check_acs(self):
        err_counter = 0
        for key in list(self.acs_des.keys()):
            if self.acs_des[key] != self.acs_src[key] and key not in check_excepts:
                print("Warning! ACS %s doesn't match!! %s/%s" % (key, self.acs_des[key], self.acs_src[key]))

        for key in key_versions:
            if self.acs_des[key] > self.acs_src[key]:
                self.acs_des[key] = self.acs_src[key]
                print('Warning! ACS src %s too old!' % key)

        for key in list(self.acs_base.keys()):
            if isinstance(self.acs_base[key], str):
                if self.acs_des[key] != self.acs_base[key]:
                    err_counter += 1
                    print('Error! ACS DES %s error!! Value: %s, Expect: %s' % (key, self.acs_des[key], self.acs_base[key]))
                if self.acs_src[key] != self.acs_base[key]:
                    err_counter += 1
                    print('Error! ACS DES %s error!! Value: %s, Expect: %s' % (key, self.acs_src[key], self.acs_base[key]))

        if self.acs_des['version'] > ACS_TOOL_VERSION:
            print('Error! Please update acs tool! v%s>v%s' % (self.acs_des['version'], ACS_TOOL_VERSION))
            err_counter += 1
        return err_counter

    def copy_data(self):
        file_des = open(self.file_des_tmp, 'r+b')
        file_src = open(self.file_src, 'rb')
        for key_addr, key_length in zip(check_excepts, check_excepts_length):
            file_des.seek(self.acs_des[key_addr])
            file_src.seek(self.acs_src[key_addr])
            file_des.write(file_src.read(self.acs_des[key_length]))

        file_des.close()
        file_src.close()
        return 0

    def run(self):
        shutil.copyfile(self.file_des, self.file_des_tmp)
        self.init_acs(self.acs_des, self.file_des_tmp, 1)
        self.init_acs(self.acs_src, self.file_src, 0)
        if self.check_acs():
            print('ACS check failed! Compile Abort!')
            return -1
        self.copy_data()
        print('ACS tool process done.')

    def log_print(self, log):
        if self.debug:
            print(log)


if __name__ == '__main__':
    if sys.argv[1] == '--help' or sys.argv[1] == '-help':
        print('acs_tool.py [bl2.bin] [bl2_tmp.bin] [acs.bin] [debug(1/0)]')
        exit(1)
    if len(sys.argv) != 5:
        print('acs_tool.py [bl2.bin] [bl2_tmp.bin] [acs.bin] [debug(1/0)]')
        exit(1)
    tool = acs_tool(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
    if tool.run():
        exit(1)
# okay decompiling acs_tool.pyc
