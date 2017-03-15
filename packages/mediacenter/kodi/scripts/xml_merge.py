#!/usr/bin/env python2

# taken from http://stackoverflow.com/a/14879370 with minor modifications

from __future__ import print_function
import os
import sys
import xml.dom.minidom
from xml.etree import ElementTree as et

def printerr(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

class XMLCombiner(object):
    def __init__(self, filenames):
        if len(filenames) == 0:
          raise Exception('No filenames!')

        try:
          self.roots = [et.parse(f).getroot() for f in filenames]
        except xml.etree.ElementTree.ParseError:
          printerr("ERROR: Unable to parse XML file %s" % f)
          raise

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
    xmlfiles = [file for file in sys.argv[1:] if os.path.exists(file)]

    r = XMLCombiner(xmlfiles).combine()

    print(r)
