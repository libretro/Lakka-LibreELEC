#!/bin/sh

git archive --format=tar --prefix=LibreELEC-source-$1/ tags/$1 | bzip2 > LibreELEC-source-$1.tar.bz2
