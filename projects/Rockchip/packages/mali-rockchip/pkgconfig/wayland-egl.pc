prefix=/usr
exec_prefix=${prefix}
libdir=${prefix}/@CMAKE_INSTALL_LIBDIR@
includedir=${prefix}/@CMAKE_INSTALL_INCLUDEDIR@

Name: wayland-egl
Description: Mali EGL library
Requires.private: 
Version: 7.10
Libs: -L${libdir} -lMali
Libs.private: -lm -lpthread
Cflags: -I${includedir} 
