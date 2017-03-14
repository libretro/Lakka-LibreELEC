#!/usr/bin/env python2

# taken from http://stackoverflow.com/a/14879370 with minor modifications

import os
import sys
import xml.dom.minidom
from xml.etree import ElementTree as et

class XMLCombiner(object):
    def __init__(self, filenames):
        assert len(filenames) > 0, 'No filenames!'
        self.roots = [et.parse(f).getroot() for f in filenames]

    def prettyPrint(self, etree_xml):
        minidom = xml.dom.minidom.parseString(et.tostring(etree_xml))
        return "\n".join([line for line in minidom.toprettyxml(indent="  ", encoding="utf-8").split('\n') if line.strip() != ""])

    def combine(self):
        for r in self.roots[1:]:
            self.combine_element(self.roots[0], r)
        return self.prettyPrint(self.roots[0])

    def combine_element(self, one, other):
        mapping = {el.tag: el for el in one}
        for el in other:
            if len(el) == 0:
                try:
                    mapping[el.tag].text = el.text
                except KeyError:
                    mapping[el.tag] = el
                    one.append(el)
            else:
                try:
                    self.combine_element(mapping[el.tag], el)
                except KeyError:
                    mapping[el.tag] = el
                    one.append(el)

if __name__ == '__main__':
    try:
        r = XMLCombiner([sys.argv[1], sys.argv[2], sys.argv[3]]).combine()
    except IOError:
        try:
            r = XMLCombiner([sys.argv[1], sys.argv[2]]).combine()
        except IOError:
            try:
                r = XMLCombiner([sys.argv[1], sys.argv[3]]).combine()
            except IOError:
                r = XMLCombiner([sys.argv[1]]).combine()
    print(r)
