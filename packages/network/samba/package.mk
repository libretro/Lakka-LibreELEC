################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="samba"
PKG_VERSION="3.6.25"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.samba.org"
PKG_URL="http://samba.org/samba/ftp/stable/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib connman"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="samba: The free SMB / CIFS fileserver and client"
PKG_LONGDESC="Samba is a SMB server that runs on Unix and other operating systems. It allows these operating systems (currently Unix, Netware, OS/2 and AmigaDOS) to act as a file and print server for SMB and CIFS clients. There are many Lan-Manager compatible clients such as LanManager for DOS, Windows for Workgroups, Windows NT, Windows 95, Linux smbfs, OS/2, Pathworks and more."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi"
  SMB_AVAHI="--enable-avahi"
else
  SMB_AVAHI="--disable-avahi"
fi

PKG_CONFIGURE_SCRIPT="source3/configure"
PKG_CONFIGURE_OPTS_TARGET="ac_cv_file__proc_sys_kernel_core_pattern=yes \
                           libreplace_cv_HAVE_C99_VSNPRINTF=yes \
                           libreplace_cv_HAVE_GETADDRINFO=no \
                           libreplace_cv_HAVE_IFACE_IFCONF=no \
                           LINUX_LFS_SUPPORT=yes \
                           samba_cv_CC_NEGATIVE_ENUM_VALUES=yes \
                           samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
                           samba_cv_HAVE_IFACE_IFCONF=yes \
                           samba_cv_HAVE_KERNEL_OPLOCKS_LINUX=yes \
                           samba_cv_HAVE_SECURE_MKSTEMP=yes \
                           samba_cv_HAVE_WRFILE_KEYTAB=no \
                           samba_cv_USE_SETREUID=yes \
                           samba_cv_USE_SETRESUID=yes \
                           samba_cv_have_setreuid=yes \
                           samba_cv_have_setresuid=yes \
                           --with-configdir=/etc/samba \
                           --with-privatedir=/var/run \
                           --with-codepagedir=/etc/samba \
                           --with-lockdir=/var/lock \
                           --with-logfilebase=/var/log \
                           --with-nmbdsocketdir=/var/nmbd \
                           --with-piddir=/var/run \
                           --disable-shared-libs \
                           --disable-debug \
                           --with-libiconv="$SYSROOT_PREFIX/usr" \
                           --disable-krb5developer \
                           --disable-picky-developer \
                           --enable-largefile \
                           --disable-socket-wrapper \
                           --disable-nss-wrapper \
                           --disable-swat \
                           --disable-cups \
                           --disable-iprint \
                           --disable-pie \
                           --disable-relro \
                           --disable-fam \
                           --disable-dnssd \
                           $SMB_AVAHI \
                           --disable-pthreadpool \
                           --disable-dmalloc \
                           --with-fhs \
                           --without-libtalloc \
                           --disable-external-libtalloc \
                           --without-libtdb \
                           --disable-external-libtdb \
                           --without-libnetapi \
                           --with-libsmbclient \
                           --without-libsmbsharemodes \
                           --without-libaddns \
                           --without-afs \
                           --without-fake-kaserver \
                           --without-vfs-afsacl \
                           --without-ldap \
                           --without-ads \
                           --without-dnsupdate \
                           --without-automount \
                           --without-krb5 \
                           --without-pam \
                           --without-pam_smbpass \
                           --without-nisplus-home \
                           --with-syslog \
                           --without-quotas \
                           --without-sys-quotas \
                           --without-utmp \
                           --without-cluster-support \
                           --without-acl-support \
                           --without-aio-support \
                           --with-sendfile-support \
                           --without-libtevent \
                           --without-wbclient \
                           --without-winbind \
                           --with-included-popt \
                           --with-included-iniparser"

pre_configure_target() {
  ( cd ../source3
    sh autogen.sh
  )

  CFLAGS="$CFLAGS -fPIC -DPIC"
  LDFLAGS="$LDFLAGS -fwhole-program"
}

make_target() {
  make bin/libtalloc.a
  make bin/libwbclient.a
  make bin/libtdb.a
  make bin/libtevent.a
  make bin/libsmbclient.a

  if [ "$SAMBA_SERVER" = "yes" ]; then
    make bin/samba_multicall
  fi
}

post_make_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -P bin/*.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/include
    cp ../source3/include/libsmbclient.h $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    # talloc/tdb/tevent/wbclient static
    sed -e "s,^Libs: -lsmbclient$,Libs: -lsmbclient -ltalloc -ltdb -ltevent -lwbclient,g" -i pkgconfig/smbclient.pc
    cp pkgconfig/smbclient.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
}

makeinstall_target() {
  if [ "$SAMBA_SERVER" = "yes" ]; then
    mkdir -p $INSTALL/usr/bin
      cp bin/samba_multicall $INSTALL/usr/bin
      ln -sf samba_multicall $INSTALL/usr/bin/smbd
      ln -sf samba_multicall $INSTALL/usr/bin/nmbd
      ln -sf samba_multicall $INSTALL/usr/bin/smbpasswd

    mkdir -p $INSTALL/etc/samba
      cp ../codepages/lowcase.dat $INSTALL/etc/samba
      cp ../codepages/upcase.dat $INSTALL/etc/samba
      cp ../codepages/valid.dat $INSTALL/etc/samba

    mkdir -p $INSTALL/usr/lib/systemd/system
      cp $PKG_DIR/system.d.opt/* $INSTALL/usr/lib/systemd/system

    mkdir -p $INSTALL/usr/share/services
      cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services

    mkdir -p $INSTALL/usr/lib/samba
      cp $PKG_DIR/scripts/samba-config $INSTALL/usr/lib/samba
      cp $PKG_DIR/scripts/samba-autoshare $INSTALL/usr/lib/samba

    if [ -f $PROJECT_DIR/$PROJECT/config/smb.conf ]; then
      mkdir -p $INSTALL/etc/samba
        cp $PROJECT_DIR/$PROJECT/config/smb.conf $INSTALL/etc/samba
    else
      mkdir -p $INSTALL/etc/samba
        cp $PKG_DIR/config/smb.conf $INSTALL/etc/samba
      mkdir -p $INSTALL/usr/config
        cp $PKG_DIR/config/smb.conf $INSTALL/usr/config/samba.conf.sample
    fi

  fi
}

post_install() {
  if [ "$SAMBA_SERVER" = "yes" ]; then
    enable_service samba-defaults.service
    enable_service nmbd.service
    enable_service smbd.service
  fi
}
