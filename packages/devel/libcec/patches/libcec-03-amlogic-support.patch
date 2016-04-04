diff --git a/README.md b/README.md
index dfaf4d6..0dffdcf 100644
--- a/README.md
+++ b/README.md
@@ -58,6 +58,12 @@
 cmake -DHAVE_EXYNOS_API=1 ..
 ```
 
+### Amlogic
+To compile in support for Amlogic devices, you have to pass the argument -DHAVE_AMLOGIC_API=1 to cmake:
+```
+cmake -DHAVE_AMLOGIC_API=1 ..
+```
+
 ## TDA995x ##
 To compile in support for TDA995x devices, you have to pass the argument -DHAVE_TDA995X_API=1 to cmake:
 ```
diff --git a/include/cectypes.h b/include/cectypes.h
index e28c8df..c0b9476 100644
--- a/include/cectypes.h
+++ b/include/cectypes.h
@@ -318,6 +318,15 @@ namespace CEC {
  */
 #define CEC_IMX_VIRTUAL_COM		"i.MX"
 
+/*!
+ * the path to use for the Amlogic HDMI CEC device
+ */
+#define CEC_AMLOGIC_PATH		"/dev/AmlogicCEC"
+
+/*!
+ * the name of the virtual COM port to use for the AMLOGIC' CEC wire
+ */
+#define CEC_AMLOGIC_VIRTUAL_COM		"Amlogic"
 
 /*!
  * Mimimum client version
@@ -889,7 +898,8 @@ typedef enum cec_adapter_type
   ADAPTERTYPE_RPI              = 0x100,
   ADAPTERTYPE_TDA995x          = 0x200,
   ADAPTERTYPE_EXYNOS           = 0x300,
-  ADAPTERTYPE_IMX              = 0x400
+  ADAPTERTYPE_IMX              = 0x400,
+  ADAPTERTYPE_AMLOGIC          = 0x500
 } cec_adapter_type;
 
 /** force exporting through swig */
diff --git a/src/libcec/CMakeLists.txt b/src/libcec/CMakeLists.txt
index a494533..e94b094 100644
--- a/src/libcec/CMakeLists.txt
+++ b/src/libcec/CMakeLists.txt
@@ -87,6 +87,9 @@ set(CEC_HEADERS devices/CECRecordingDevice.h
                 adapter/Exynos/ExynosCEC.h
                 adapter/Exynos/ExynosCECAdapterDetection.h
                 adapter/Exynos/ExynosCECAdapterCommunication.h
+                adapter/Amlogic/AmlogicCEC.h
+                adapter/Amlogic/AmlogicCECAdapterDetection.h
+                adapter/Amlogic/AmlogicCECAdapterCommunication.h
                 adapter/Pulse-Eight/USBCECAdapterMessageQueue.h
                 adapter/Pulse-Eight/USBCECAdapterCommunication.h
                 adapter/Pulse-Eight/USBCECAdapterCommands.h
diff --git a/src/libcec/adapter/AdapterFactory.cpp b/src/libcec/adapter/AdapterFactory.cpp
index 92e378b..55703b9 100644
--- a/src/libcec/adapter/AdapterFactory.cpp
+++ b/src/libcec/adapter/AdapterFactory.cpp
@@ -63,6 +63,11 @@
 #include "IMX/IMXCECAdapterCommunication.h"
 #endif
 
+#if defined(HAVE_AMLOGIC_API)
+#include "Amlogic/AmlogicCECAdapterDetection.h"
+#include "Amlogic/AmlogicCECAdapterCommunication.h"
+#endif
+
 using namespace CEC;
 
 int8_t CAdapterFactory::FindAdapters(cec_adapter *deviceList, uint8_t iBufSize, const char *strDevicePath /* = NULL */)
@@ -131,8 +136,6 @@ int8_t CAdapterFactory::DetectAdapters(cec_adapter_descriptor *deviceList, uint8
   }
 #endif
 
-
-
 #if defined(HAVE_IMX_API)
   if (iAdaptersFound < iBufSize && CIMXCECAdapterDetection::FindAdapter() &&
       (!strDevicePath || !strcmp(strDevicePath, CEC_IMX_VIRTUAL_COM)))
@@ -146,8 +149,20 @@ int8_t CAdapterFactory::DetectAdapters(cec_adapter_descriptor *deviceList, uint8
   }
 #endif
 
+#if defined(HAVE_AMLOGIC_API)
+  if (iAdaptersFound < iBufSize && CAmlogicCECAdapterDetection::FindAdapter())
+  {
+    snprintf(deviceList[iAdaptersFound].strComPath, sizeof(deviceList[iAdaptersFound].strComPath), CEC_AMLOGIC_PATH);
+    snprintf(deviceList[iAdaptersFound].strComName, sizeof(deviceList[iAdaptersFound].strComName), CEC_AMLOGIC_VIRTUAL_COM);
+    deviceList[iAdaptersFound].iVendorId = 0;
+    deviceList[iAdaptersFound].iProductId = 0;
+    deviceList[iAdaptersFound].adapterType = ADAPTERTYPE_AMLOGIC;
+    iAdaptersFound++;
+  }
+#endif
 
-#if !defined(HAVE_RPI_API) && !defined(HAVE_P8_USB) && !defined(HAVE_TDA995X_API) && !defined(HAVE_IMX_API)
+
+#if !defined(HAVE_RPI_API) && !defined(HAVE_P8_USB) && !defined(HAVE_TDA995X_API) && !defined(HAVE_IMX_API) && !defined(HAVE_AMLOGIC_API)
 #error "libCEC doesn't have support for any type of adapter. please check your build system or configuration"
 #endif
 
@@ -176,11 +191,16 @@ IAdapterCommunication *CAdapterFactory::GetInstance(const char *strPort, uint16_
     return new CIMXCECAdapterCommunication(m_lib->m_cec);
 #endif
 
+#if defined(HAVE_AMLOGIC_API)
+  if (!strcmp(strPort, CEC_AMLOGIC_VIRTUAL_COM))
+    return new CAmlogicCECAdapterCommunication(m_lib->m_cec);
+#endif
+
 #if defined(HAVE_P8_USB)
   return new CUSBCECAdapterCommunication(m_lib->m_cec, strPort, iBaudRate);
 #endif
 
-#if !defined(HAVE_RPI_API) && !defined(HAVE_P8_USB) && !defined(HAVE_TDA995X_API) && !defined(HAVE_EXYNOS_API) && !defined(HAVE_IMX_API)
+#if !defined(HAVE_RPI_API) && !defined(HAVE_P8_USB) && !defined(HAVE_TDA995X_API) && !defined(HAVE_EXYNOS_API) && !defined(HAVE_IMX_API) && !defined(HAVE_AMLOGIC_API)
   return NULL;
 #endif
 }
diff --git a/src/libcec/adapter/Amlogic/AmlogicCEC.h b/src/libcec/adapter/Amlogic/AmlogicCEC.h
new file mode 100644
index 0000000..7b86982
--- /dev/null
+++ b/src/libcec/adapter/Amlogic/AmlogicCEC.h
@@ -0,0 +1,41 @@
+#pragma once
+/*
+ * This file is part of the libCEC(R) library.
+ *
+ * libCEC Amlogic Code Copyright (C) 2016 Gerald Dachs
+ * based heavily on:
+ * libCEC Exynos Code Copyright (C) 2014 Valentin Manea
+ * libCEC(R) is Copyright (C) 2011-2015 Pulse-Eight Limited.  All rights reserved.
+ * libCEC(R) is an original work, containing original code.
+ *
+ * libCEC(R) is a trademark of Pulse-Eight Limited.
+ *
+ * This program is dual-licensed; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *
+ * Alternatively, you can license this library under a commercial license,
+ * please contact Pulse-Eight Licensing for more information.
+ *
+ * For more information contact:
+ * Pulse-Eight Licensing       <license@pulse-eight.com>
+ *     http://www.pulse-eight.com/
+ *     http://www.pulse-eight.net/
+ */
+
+
+#define CEC_DEFAULT_PADDR   0x1000
+#define CEC_IOC_SETLADDR    _IOW('c', 0, unsigned int)
+#define CEC_IOC_GETPADDR    _IO('c', 1)
+#define CEC_MAX_FRAME_SIZE  16
diff --git a/src/libcec/adapter/Amlogic/AmlogicCECAdapterCommunication.cpp b/src/libcec/adapter/Amlogic/AmlogicCECAdapterCommunication.cpp
new file mode 100644
index 0000000..5aeddda
--- /dev/null
+++ b/src/libcec/adapter/Amlogic/AmlogicCECAdapterCommunication.cpp
@@ -0,0 +1,305 @@
+/*
+ * This file is part of the libCEC(R) library.
+ *
+ * libCEC Amlogic Code Copyright (C) 2016 Gerald Dachs
+ * based heavily on:
+ * libCEC Exynos Code Copyright (C) 2014 Valentin Manea
+ * libCEC(R) is Copyright (C) 2011-2015 Pulse-Eight Limited.  All rights reserved.
+ * libCEC(R) is an original work, containing original code.
+ *
+ * libCEC(R) is a trademark of Pulse-Eight Limited.
+ *
+ * This program is dual-licensed; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *
+ * Alternatively, you can license this library under a commercial license,
+ * please contact Pulse-Eight Licensing for more information.
+ *
+ * For more information contact:
+ * Pulse-Eight Licensing       <license@pulse-eight.com>
+ *     http://www.pulse-eight.com/
+ *     http://www.pulse-eight.net/
+ */
+
+#include "env.h"
+#include <fcntl.h>
+#include <sys/ioctl.h>
+
+
+#if defined(HAVE_AMLOGIC_API)
+#include "AmlogicCEC.h"
+#include "AmlogicCECAdapterCommunication.h"
+
+#include "CECTypeUtils.h"
+#include "LibCEC.h"
+#include <platform/util/buffer.h>
+
+using namespace CEC;
+using namespace PLATFORM;
+
+#define LIB_CEC m_callback->GetLib()
+
+
+CAmlogicCECAdapterCommunication::CAmlogicCECAdapterCommunication(IAdapterCommunicationCallback *callback) :
+    IAdapterCommunication(callback),
+    m_bLogicalAddressChanged(false)
+{ 
+  CLockObject lock(m_mutex);
+
+  m_logicalAddresses.Clear();
+  m_fd = INVALID_SOCKET_VALUE;
+}
+
+
+CAmlogicCECAdapterCommunication::~CAmlogicCECAdapterCommunication(void)
+{
+  Close();
+}
+
+
+bool CAmlogicCECAdapterCommunication::IsOpen(void)
+{
+  CLockObject lock(m_mutex);
+  return IsInitialised() && m_fd != INVALID_SOCKET_VALUE;
+}
+
+
+bool CAmlogicCECAdapterCommunication::Open(uint32_t UNUSED(iTimeoutMs), bool UNUSED(bSkipChecks), bool bStartListening)
+{
+  if (IsOpen())
+    Close();
+
+  CLockObject lock(m_mutex);
+
+  if ((m_fd = open(CEC_AMLOGIC_PATH, O_RDWR)) > 0)
+  {
+    if (!bStartListening || CreateThread()) {
+        return true;
+    }
+    close(m_fd);
+    m_fd = INVALID_SOCKET_VALUE;
+  }
+  return false;
+}
+
+
+void CAmlogicCECAdapterCommunication::Close(void)
+{
+  StopThread(0);
+
+  CLockObject lock(m_mutex);
+
+  close(m_fd);
+  m_fd = INVALID_SOCKET_VALUE;
+}
+
+
+std::string CAmlogicCECAdapterCommunication::GetError(void) const
+{
+  std::string strError(m_strError);
+  return strError;
+}
+
+int CAmlogicCECAdapterCommunication::getFileDescriptor(void)
+{
+  CLockObject lock(m_mutex);
+
+  return m_fd;
+}
+
+
+
+cec_adapter_message_state CAmlogicCECAdapterCommunication::Write(
+  const cec_command &data, bool &UNUSED(bRetry), uint8_t UNUSED(iLineTimeout), bool UNUSED(bIsReply))
+{
+  uint8_t buffer[CEC_MAX_FRAME_SIZE];
+  int32_t size = 1;
+  cec_adapter_message_state rc = ADAPTER_MESSAGE_STATE_ERROR;
+
+  if (!IsOpen())
+    return rc;
+
+  CLockObject lock(m_mutex);
+
+  if ((size_t)data.parameters.size + data.opcode_set > sizeof(buffer))
+  {
+    LIB_CEC->AddLog(CEC_LOG_ERROR, "%s: data size too large !", __func__);
+    return ADAPTER_MESSAGE_STATE_ERROR;
+  }
+ 
+  buffer[0] = (data.initiator << 4) | (data.destination & 0x0f);
+
+  if (data.opcode_set)
+  {
+    buffer[1] = data.opcode;
+    size++;
+
+    memcpy(&buffer[size], data.parameters.data, data.parameters.size);
+    size += data.parameters.size;
+  }
+
+  if (write(m_fd, (void *)buffer, size) == size)
+  {
+    rc = ADAPTER_MESSAGE_STATE_SENT_ACKED;
+  }
+  else
+  {
+    LIB_CEC->AddLog(CEC_LOG_ERROR, "%s: write failed !", __func__);
+  }
+
+  return rc;
+}
+
+
+uint16_t CAmlogicCECAdapterCommunication::GetFirmwareVersion(void)
+{
+  return 0;
+}
+
+
+cec_vendor_id CAmlogicCECAdapterCommunication::GetVendorId(void)
+{
+  return cec_vendor_id(CEC_VENDOR_UNKNOWN);
+}
+
+
+uint16_t CAmlogicCECAdapterCommunication::GetPhysicalAddress(void)
+{
+  int phys_addr = CEC_DEFAULT_PADDR;
+
+  if (!IsOpen())
+    return (uint16_t)phys_addr;
+
+  CLockObject lock(m_mutex);
+
+  if ((phys_addr = ioctl(m_fd, CEC_IOC_GETPADDR)) < 0)
+  {
+    LIB_CEC->AddLog(CEC_LOG_ERROR, "%s: IOCTL GetPhysicalAddr failed !", __func__);
+    phys_addr = CEC_DEFAULT_PADDR;
+  }
+  return (uint16_t)phys_addr;
+}
+
+
+cec_logical_addresses CAmlogicCECAdapterCommunication::GetLogicalAddresses(void)
+{
+  return m_logicalAddresses;
+}
+
+
+bool CAmlogicCECAdapterCommunication::SetLogicalAddresses(const cec_logical_addresses &addresses)
+{
+  unsigned int log_addr = addresses.primary;
+  if (!IsOpen())
+    return false;
+
+  CLockObject lock(m_mutex);
+
+  if (ioctl(m_fd, CEC_IOC_SETLADDR, &log_addr))
+  {
+    LIB_CEC->AddLog(CEC_LOG_ERROR, "%s: IOCTL SetLogicalAddr failed !", __func__);
+    return false;
+  }
+  m_logicalAddresses = addresses;
+  m_bLogicalAddressChanged = true;
+
+  return true;
+}
+
+
+void CAmlogicCECAdapterCommunication::HandleLogicalAddressLost(cec_logical_address UNUSED(oldAddress))
+{
+  unsigned int log_addr = CECDEVICE_BROADCAST;
+
+  if (!IsOpen())
+    return;
+
+  CLockObject lock(m_mutex);
+
+  if (ioctl(m_fd, CEC_IOC_SETLADDR, &log_addr))
+  {
+    LIB_CEC->AddLog(CEC_LOG_ERROR, "%s: IOCTL SetLogicalAddr failed !", __func__);
+  }
+}
+
+
+void *CAmlogicCECAdapterCommunication::Process(void)
+{
+  uint8_t buffer[CEC_MAX_FRAME_SIZE];
+  uint32_t size;
+  fd_set rfds;
+  cec_logical_address initiator, destination;
+  struct timeval tv;
+
+  if (!IsOpen())
+    return 0;
+
+  while (!IsStopped())
+  {
+    int fd = getFileDescriptor();
+
+    if (fd == INVALID_SOCKET_VALUE)
+    {
+      break;
+    }
+
+    FD_ZERO(&rfds);
+    FD_SET(fd, &rfds);
+
+    tv.tv_sec = 1;
+    tv.tv_usec = 0;
+
+    if (select(fd + 1, &rfds, NULL, NULL, &tv) >= 0 )
+    {
+
+      if (!FD_ISSET(fd, &rfds))
+	  continue;
+
+      size = read(fd, buffer, CEC_MAX_FRAME_SIZE);
+
+      if (size > 0)
+      {
+          if (buffer[0] == 0xff) // driver wants us to reread the physical address
+          {
+              if (!IsStopped())
+              {
+                  uint16_t iNewAddress = GetPhysicalAddress();
+                  m_callback->HandlePhysicalAddressChanged(iNewAddress);
+              }
+              continue;
+          }
+
+          initiator = cec_logical_address(buffer[0] >> 4);
+          destination = cec_logical_address(buffer[0] & 0x0f);
+
+          cec_command cmd;
+
+          cec_command::Format(
+            cmd, initiator, destination,
+            ( size > 1 ) ? cec_opcode(buffer[1]) : CEC_OPCODE_NONE);
+
+          for( uint8_t i = 2; i < size; i++ )
+            cmd.parameters.PushBack(buffer[i]);
+
+          if (!IsStopped())
+            m_callback->OnCommandReceived(cmd);
+      }
+    }
+  }
+
+  return 0;
+}
+
+#endif	// HAVE_AMLOGIC_API
diff --git a/src/libcec/adapter/Amlogic/AmlogicCECAdapterCommunication.h b/src/libcec/adapter/Amlogic/AmlogicCECAdapterCommunication.h
new file mode 100644
index 0000000..0e99cf8
--- /dev/null
+++ b/src/libcec/adapter/Amlogic/AmlogicCECAdapterCommunication.h
@@ -0,0 +1,105 @@
+#pragma once
+/*
+ * This file is part of the libCEC(R) library.
+ *
+ * libCEC Amlogic Code Copyright (C) 2016 Gerald Dachs
+ * based heavily on:
+ * libCEC Exynos Code Copyright (C) 2014 Valentin Manea
+ * libCEC(R) is Copyright (C) 2011-2015 Pulse-Eight Limited.  All rights reserved.
+ * libCEC(R) is an original work, containing original code.
+ *
+ * libCEC(R) is a trademark of Pulse-Eight Limited.
+ *
+ * This program is dual-licensed; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *
+ * Alternatively, you can license this library under a commercial license,
+ * please contact Pulse-Eight Licensing for more information.
+ *
+ * For more information contact:
+ * Pulse-Eight Licensing       <license@pulse-eight.com>
+ *     http://www.pulse-eight.com/
+ *     http://www.pulse-eight.net/
+ */
+
+#include "env.h"
+
+#if defined(HAVE_AMLOGIC_API)
+
+#include <platform/threads/mutex.h>
+#include <platform/threads/threads.h>
+#include "../AdapterCommunication.h"
+#include <map>
+
+namespace CEC
+{
+  class CAmlogicCECAdapterCommunication : public IAdapterCommunication, public PLATFORM::CThread
+  {
+  public:
+    /*!
+     * @brief Create a new Exynos HDMI CEC communication handler.
+     * @param callback The callback to use for incoming CEC commands.
+     */
+    CAmlogicCECAdapterCommunication(IAdapterCommunicationCallback *callback);
+    virtual ~CAmlogicCECAdapterCommunication(void);
+
+    /** @name IAdapterCommunication implementation */
+    ///{
+    bool Open(uint32_t iTimeoutMs = CEC_DEFAULT_CONNECT_TIMEOUT, bool bSkipChecks = false, bool bStartListening = true);
+    void Close(void);
+    bool IsOpen(void);
+    std::string GetError(void) const;
+    cec_adapter_message_state Write(const cec_command &data, bool &bRetry, uint8_t iLineTimeout, bool bIsReply);
+
+    bool SetLineTimeout(uint8_t UNUSED(iTimeout)) { return true; }
+    bool StartBootloader(void) { return false; }
+    bool SetLogicalAddresses(const cec_logical_addresses &addresses);
+    cec_logical_addresses GetLogicalAddresses(void);
+    bool PingAdapter(void) { return IsInitialised(); }
+    uint16_t GetFirmwareVersion(void);
+    uint32_t GetFirmwareBuildDate(void) { return 0; }
+    bool IsRunningLatestFirmware(void) { return true; }
+    bool PersistConfiguration(const libcec_configuration & UNUSED(configuration)) { return false; }
+    bool GetConfiguration(libcec_configuration & UNUSED(configuration)) { return false; }
+    std::string GetPortName(void) { return std::string("AMLOGIC"); }
+    uint16_t GetPhysicalAddress(void);
+    bool SetControlledMode(bool UNUSED(controlled)) { return true; }
+    cec_vendor_id GetVendorId(void);
+    bool SupportsSourceLogicalAddress(const cec_logical_address address) { return address > CECDEVICE_TV && address <= CECDEVICE_BROADCAST; }
+    cec_adapter_type GetAdapterType(void) { return ADAPTERTYPE_AMLOGIC; }
+    uint16_t GetAdapterVendorId(void) const { return 1; }
+    uint16_t GetAdapterProductId(void) const { return 1; }
+    void HandleLogicalAddressLost(cec_logical_address oldAddress);
+    void SetActiveSource(bool UNUSED(bSetTo), bool UNUSED(bClientUnregistered)) {}
+    ///}
+
+    /** @name PLATFORM::CThread implementation */
+    ///{
+    void *Process(void);
+    ///}
+
+  private:
+    bool IsInitialised(void) const { return 1; };
+    int getFileDescriptor(void);
+
+    std::string                 m_strError; /**< current error message */
+
+    bool                        m_bLogicalAddressChanged;
+    cec_logical_addresses       m_logicalAddresses;
+    PLATFORM::CMutex	        m_mutex;
+    int                         m_fd;
+  };
+};
+#endif
diff --git a/src/libcec/adapter/Amlogic/AmlogicCECAdapterDetection.cpp b/src/libcec/adapter/Amlogic/AmlogicCECAdapterDetection.cpp
new file mode 100644
index 0000000..2247346
--- /dev/null
+++ b/src/libcec/adapter/Amlogic/AmlogicCECAdapterDetection.cpp
@@ -0,0 +1,50 @@
+/*
+ * This file is part of the libCEC(R) library.
+ *
+ * libCEC Amlogic Code Copyright (C) 2016 Gerald Dachs
+ * based heavily on:
+ * libCEC Exynos Code Copyright (C) 2014 Valentin Manea
+ * libCEC(R) is Copyright (C) 2011-2015 Pulse-Eight Limited.  All rights reserved.
+ * libCEC(R) is an original work, containing original code.
+ *
+ * libCEC(R) is a trademark of Pulse-Eight Limited.
+ *
+ * This program is dual-licensed; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *
+ * Alternatively, you can license this library under a commercial license,
+ * please contact Pulse-Eight Licensing for more information.
+ *
+ * For more information contact:
+ * Pulse-Eight Licensing       <license@pulse-eight.com>
+ *     http://www.pulse-eight.com/
+ *     http://www.pulse-eight.net/
+ */
+
+#include "env.h"
+#include <stdio.h>
+
+#if defined(HAVE_AMLOGIC_API)
+#include "AmlogicCECAdapterDetection.h"
+#include "AmlogicCEC.h"
+
+using namespace CEC;
+
+bool CAmlogicCECAdapterDetection::FindAdapter(void)
+{
+  return access(CEC_AMLOGIC_PATH, 0) == 0;
+}
+
+#endif
diff --git a/src/libcec/adapter/Amlogic/AmlogicCECAdapterDetection.h b/src/libcec/adapter/Amlogic/AmlogicCECAdapterDetection.h
new file mode 100644
index 0000000..8a7418d
--- /dev/null
+++ b/src/libcec/adapter/Amlogic/AmlogicCECAdapterDetection.h
@@ -0,0 +1,46 @@
+#pragma once
+/*
+ * This file is part of the libCEC(R) library.
+ *
+ * libCEC Amlogic Code Copyright (C) 2016 Gerald Dachs
+ * based heavily on:
+ * libCEC Exynos Code Copyright (C) 2014 Valentin Manea
+ * libCEC(R) is Copyright (C) 2011-2015 Pulse-Eight Limited.  All rights reserved.
+ * libCEC(R) is an original work, containing original code.
+ *
+ * libCEC(R) is a trademark of Pulse-Eight Limited.
+ *
+ * This program is dual-licensed; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *
+ * Alternatively, you can license this library under a commercial license,
+ * please contact Pulse-Eight Licensing for more information.
+ *
+ * For more information contact:
+ * Pulse-Eight Licensing       <license@pulse-eight.com>
+ *     http://www.pulse-eight.com/
+ *     http://www.pulse-eight.net/
+ */
+
+#include "env.h"
+
+namespace CEC
+{
+  class CAmlogicCECAdapterDetection
+  {
+  public:
+    static bool FindAdapter(void);
+  };
+}
diff --git a/src/libcec/cmake/CheckPlatformSupport.cmake b/src/libcec/cmake/CheckPlatformSupport.cmake
index dc5bc25..64003d9 100644
--- a/src/libcec/cmake/CheckPlatformSupport.cmake
+++ b/src/libcec/cmake/CheckPlatformSupport.cmake
@@ -11,6 +11,7 @@
 #	HAVE_IMX_API              1 if i.MX is supported
 #	HAVE_TDA995X_API          1 if TDA995X is supported
 #	HAVE_EXYNOS_API           1 if Exynos is supported
+#	HAVE_AMLOGIC_API          1 if Amlogic is supported
 #       HAVE_P8_USB_DETECT        1 if Pulse-Eight devices can be auto-detected
 #
 
@@ -142,6 +143,18 @@ else()
   else()
     set(HAVE_EXYNOS_API 0)
   endif()
+
+  # Amlogic
+  if (${HAVE_AMLOGIC_API})
+    set(LIB_INFO "${LIB_INFO}, Amlogic")
+    set(HAVE_AMLOGIC_API 1)
+    set(CEC_SOURCES_ADAPTER_AMLOGIC adapter/Amlogic/AmlogicCECAdapterDetection.cpp
+                                   adapter/Amlogic/AmlogicCECAdapterCommunication.cpp)
+    source_group("Source Files\\adapter\\Amlogic" FILES ${CEC_SOURCES_ADAPTER_AMLOGIC})
+    list(APPEND CEC_SOURCES ${CEC_SOURCES_ADAPTER_AMLOGIC})
+  else()
+    set(HAVE_AMLOGIC_API 0)
+  endif()
 endif()
 
 # rt
diff --git a/src/libcec/cmake/DisplayPlatformSupport.cmake b/src/libcec/cmake/DisplayPlatformSupport.cmake
index 4e24def..1890cac 100644
--- a/src/libcec/cmake/DisplayPlatformSupport.cmake
+++ b/src/libcec/cmake/DisplayPlatformSupport.cmake
@@ -50,6 +50,12 @@ else()
   message(STATUS "DRM support:                            no")
 endif()
 
+if (HAVE_AMLOGIC_API)
+  message(STATUS "Amlogic support:                        yes")
+else()
+  message(STATUS "Amlogic support:                        no")
+endif()
+
 if (HAVE_PYTHON)
   message(STATUS "Python support:                         version ${PYTHONLIBS_VERSION_STRING} (${PYTHON_VERSION})")
 else()
diff --git a/src/libcec/env.h.in b/src/libcec/env.h.in
index 384f1c7..c3f00bc 100644
--- a/src/libcec/env.h.in
+++ b/src/libcec/env.h.in
@@ -75,6 +75,9 @@
 /* Define to 1 for Exynos support */
 #cmakedefine HAVE_EXYNOS_API @HAVE_EXYNOS_API@
 
+/* Define to 1 for Amlogic support */
+#cmakedefine HAVE_AMLOGIC_API @HAVE_AMLOGIC_API@
+
 /* Define to 1 for nVidia EDID parsing support (on selected models) */
 #cmakedefine HAVE_NVIDIA_EDID_PARSER @HAVE_NVIDIA_EDID_PARSER@
 
