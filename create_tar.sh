#!/bin/sh

git archive --format=tar --prefix=OpenELEC-source-$1/ tags/$1 | bzip2 > OpenELEC-source-$1.tar.bz2
