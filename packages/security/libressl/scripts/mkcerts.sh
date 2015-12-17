#!/bin/bash

# adapted from fedora http://pkgs.fedoraproject.org/cgit/ca-certificates.git/tree/ca-certificates.spec

curl -L -O -s https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/nssckbi.h > /dev/null
curl -L -O -s https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt > /dev/null

mkdir bundle
mkdir certs
mkdir certs/legacy-default
mkdir certs/legacy-disable
mkdir java

cd certs
 cp ../certdata.txt .
 python ../certdata2pem.py >/dev/null
cd ..

 (
   cat <<EOF
# This is a bundle of X.509 certificates of public Certificate
# Authorities.  It was generated from the Mozilla root CA list.
# These certificates are in the OpenSSL "TRUSTED CERTIFICATE"
# format and have trust bits set accordingly.
# An exception are auxiliary certificates, without positive or negative
# trust, but are used to assist in finding a preferred trust path.
# Those neutral certificates use the plain BEGIN CERTIFICATE format.
#
# Source: nss/lib/ckfw/builtins/certdata.txt
# Source: nss/lib/ckfw/builtins/nssckbi.h
#
# Generated from:
EOF
   cat nssckbi.h | grep -w NSS_BUILTINS_LIBRARY_VERSION | awk '{print "# " $2 " " $3}';
   echo '#';
 ) > bundle/ca-bundle.trust.crt
 touch bundle/ca-bundle.neutral-trust.crt
 for f in certs/*.crt; do 
   echo "processing $f"
   tbits=`sed -n '/^# openssl-trust/{s/^.*=//;p;}' $f`
   distbits=`sed -n '/^# openssl-distrust/{s/^.*=//;p;}' $f`
   alias=`sed -n '/^# alias=/{s/^.*=//;p;q;}' $f | sed "s/'//g" | sed 's/"//g'`
   targs=""
   if [ -n "$tbits" ]; then
      for t in $tbits; do
         targs="${targs} -addtrust $t"
      done
   fi
   if [ -n "$distbits" ]; then
      for t in $distbits; do
         targs="${targs} -addreject $t"
      done
   fi
   if [ -n "$targs" ]; then
      echo "trust flags $targs for $f" >> bundle/info.trust
      openssl x509 -text -in "$f" -trustout $targs -setalias "$alias" >> bundle/ca-bundle.trust.crt
   else
      echo "no trust flags for $f" >> bundle/info.notrust
      # p11-kit-trust defines empty trust lists as "rejected for all purposes".
      # That's why we use the simple file format
      #   (BEGIN CERTIFICATE, no trust information)
      # because p11-kit-trust will treat it as a certificate with neutral trust.
      # This means we cannot use the -setalias feature for neutral trust certs.
      openssl x509 -text -in "$f" >> bundle/ca-bundle.neutral-trust.crt
   fi
 done

 for f in certs/legacy-default/*.crt; do 
   echo "processing $f"
   tbits=`sed -n '/^# openssl-trust/{s/^.*=//;p;}' $f`
   alias=`sed -n '/^# alias=/{s/^.*=//;p;q;}' $f | sed "s/'//g" | sed 's/"//g'`
   targs=""
   if [ -n "$tbits" ]; then
      for t in $tbits; do
         targs="${targs} -addtrust $t"
      done
   fi
   if [ -n "$targs" ]; then
      echo "legacy default flags $targs for $f" >> bundle/info.trust
      openssl x509 -text -in "$f" -trustout $targs -setalias "$alias" >> bundle/ca-bundle.legacy.default.crt
   fi
 done

 for f in certs/legacy-disable/*.crt; do 
   echo "processing $f"
   tbits=`sed -n '/^# openssl-trust/{s/^.*=//;p;}' $f`
   alias=`sed -n '/^# alias=/{s/^.*=//;p;q;}' $f | sed "s/'//g" | sed 's/"//g'`
   targs=""
   if [ -n "$tbits" ]; then
      for t in $tbits; do
         targs="${targs} -addtrust $t"
      done
   fi
   if [ -n "$targs" ]; then
      echo "legacy disable flags $targs for $f" >> bundle/info.trust
      openssl x509 -text -in "$f" -trustout $targs -setalias "$alias" >> bundle/ca-bundle.legacy.disable.crt
   fi
 done

 P11FILES=`find certs -name *.p11-kit | wc -l`
 if [ $P11FILES -ne 0 ]; then
   for p in certs/*.p11-kit; do 
     cat "$p" >> bundle/ca-bundle.supplement.p11-kit
   done
 fi

./update-ca-trust etc/ssl

cp -f etc/ssl/pem/tls-ca-bundle.pem ../cert/ca-bundle.crt

rm -rf nssckbi.h
rm -rf certdata.txt
rm -rf bundle
rm -rf certs
rm -rf java
rm -rf etc
