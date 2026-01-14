#!/usr/bin/python3
# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

# Additional python3 modules required (ubuntu 22.04)
#sudo apt update; sudo apt install -y python3-requests python3-bs4
import sys
import requests
import hashlib
from bs4 import BeautifulSoup

def pkgheader(pkgname, version):
    print('# SPDX-License-Identifier: GPL-2.0-only')
    print('# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)')
    print('')
    print('PKG_NAME="'+pkgname+'"')
    print('PKG_VERSION="'+version+'"')
    print('PKG_LICENSE="MIT"')
    print('PKG_SITE="https://dotnet.microsoft.com/"')
    print('PKG_DEPENDS_TARGET="toolchain"')
    print('PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."')
    print('PKG_TOOLCHAIN="manual"')
    print('')
    print('case "${ARCH}" in')

def pkgfooter():
    print('esac')
    print('PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"')

def printUrl(package, version, platform):
    try:
        url = 'https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/{0}-{1}-linux-{2}-binaries'.format(package, version, platform)
        resp = requests.get(url)
        html = BeautifulSoup(resp.text,features="lxml")
        for copybox in html.find_all('div', class_='copy-box'):
            for href in copybox.find_all('a', href=True):
                bin = requests.get(href.text)
                hashed_string = hashlib.sha256(bin.content).hexdigest()
                match platform:
                    case 'arm64':
                        le_arch = 'aarch64'
                    case 'arm32':
                        le_arch = 'arm'
                    case 'x64':
                        le_arch = 'x86_64'
                print ('  "'+le_arch+'")')
                print ('    PKG_SHA256="'+hashed_string+'"')
                print ('    PKG_URL="'+href.text+'"')
                print ('    ;;')
                #bin = requests.get(href.text)
                #hashed_string = hashlib.sha512(bin.content).hexdigest()
                #print(hashed_string)
            #checksum = copybox.find('input', id='checksum')
            #if checksum != None:
            #    print(checksum['value'])

    except Exception as err:
        print (str(err))

# main.py
if __name__== "__main__":
    #print(f"Arguments count: {len(sys.argv)}")
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} PKG_VERSION")
        sys.exit()

    #packages = ['runtime', 'runtime-aspnetcore']
    packages = ['runtime-aspnetcore']
    platforms = [ 'arm64', 'arm32', 'x64' ]
    version = sys.argv[1]
    release = version.split(".")
    for package in packages:
        pkgheader('aspnet'+release[0]+'-runtime', version)
        for platform in platforms:
            printUrl(package, version, platform)
        pkgfooter()
