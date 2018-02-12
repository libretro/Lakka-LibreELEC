#!/usr/bin/python

"""
Author: SpliFF
License: Public Domain

Python ioctl constants and functions module

Mostly follows specifications in asm-generic/ioctl.h from linux 2.5.36

Notable differences:
* no architecture dependant stuff
* size parameters are all passed as bytes, not types (ie pass 4, not int)

!! WARNING EXPERIMENTAL SOFTWARE !!
Make sure the values returned by these functions are properly tested before using fcntl on anything remotely valuable!
"""

NRBITS = 8
TYPEBITS = 8

# may be arch dependent

SIZEBITS = 14
DIRBITS = 2

NRMASK = (1 << NRBITS) - 1
TYPEMASK = (1 << TYPEBITS) - 1
SIZEMASK = (1 << SIZEBITS) - 1
DIRMASK = (1 << DIRBITS) - 1

NRSHIFT = 0
TYPESHIFT = NRSHIFT + NRBITS
SIZESHIFT = TYPESHIFT + TYPEBITS
DIRSHIFT = SIZESHIFT + SIZEBITS

# may be arch dependent

NONE = 0x0
WRITE = 0x1
READ = 0x2

# for the drivers/sound files...

IN = WRITE << DIRSHIFT
OUT = READ << DIRSHIFT
INOUT = (WRITE | READ) << DIRSHIFT
IOCSIZE_MASK = SIZEMASK << SIZESHIFT
IOCSIZE_SHIFT = SIZESHIFT

# used to create numbers ...

def IO( _type, nr):
    return IOC(NONE, _type, nr, 0)

def IOC(direction, _type, nr, size):
    return (direction << DIRSHIFT) | (_type << TYPESHIFT) | (nr << NRSHIFT) | (size << SIZESHIFT)

def IOR( _type, nr, size):
    return IOC(READ, _type, nr, size)

def IOW(_type, nr, size):
    return IOC(WRITE, _type, nr, size)

def IOWR(_type, nr, size):
    return IOC(READ|WRITE, _type, nr, size)

def IOR_BAD(_type, nr, size):
    return IOC(READ, _type, nr, size)

def IOW_BAD(_type, nr, size):
    return IOC(WRITE, _type, nr, size)

def IOWR_BAD(_type, nr, size):
    return IOC(READ|WRITE, _type, nr, size)

# used to decode ioctl numbers..

def DIR(nr):
    return (nr >> DIRSHIFT) & DIRMASK

def TYPE(nr):
    return (nr >> TYPESHIFT) & TYPEMASK

def NR(nr):
    return (nr >> NRSHIFT) & NRMASK

def SIZE(nr):
    return (nr >> SIZESHIFT) & SIZEMASK
