From f040af300925c03a1547ff02d71921bde9893330 Mon Sep 17 00:00:00 2001
From: fritsch <Peter.Fruehberger@gmail.com>
Date: Sat, 14 Jan 2017 10:23:11 +0100
Subject: [PATCH] VAAPI/VDPAU: Integration specific to LibreELEC

---
 xbmc/settings/Settings.cpp | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/xbmc/settings/Settings.cpp b/xbmc/settings/Settings.cpp
index 9940b6a..d7575f0 100644
--- a/xbmc/settings/Settings.cpp
+++ b/xbmc/settings/Settings.cpp
@@ -77,6 +77,7 @@
 #include "utils/log.h"
 #include "utils/RssManager.h"
 #include "utils/StringUtils.h"
+#include "utils/SysfsUtils.h"
 #include "utils/SystemInfo.h"
 #include "utils/Weather.h"
 #include "utils/XBMCTinyXML.h"
@@ -914,8 +915,24 @@ void CSettings::InitializeDefaults()
 
   if (g_application.IsStandAlone())
     ((CSettingInt*)m_settingsManager->GetSetting(CSettings::SETTING_POWERMANAGEMENT_SHUTDOWNSTATE))->SetDefault(POWERSTATE_SHUTDOWN);
+
+
+// LibreELEC integration patch. We ship a special limited range intel kernel patch
+// that enables us to control the full / limited / clamping with just altering
+// the kodi limitedrange setting.
+// For intel we use Limited Range, for nvidia we use full range
+// that setting is also used to enable vdpau on nvidia only, vaapi on intel only
+#if ((defined(HAVE_LIBVA) || defined(HAVE_LIBVDPAU)))
+  std::string gpuvendor;
+  SysfsUtils::GetString("/proc/fb", gpuvendor);
+  bool isIntel = StringUtils::EndsWith(gpuvendor, "inteldrmfb");
+  // Intel driver is operating in passthrough mode so use limited range by default
+  ((CSettingBool*)GetSetting(CSettings::SETTING_VIDEOSCREEN_LIMITEDRANGE))->SetDefault(isIntel);
+  ((CSettingBool*)GetSetting(CSettings::SETTING_VIDEOPLAYER_USEVAAPI))->SetDefault(isIntel);
+  ((CSettingBool*)GetSetting(CSettings::SETTING_VIDEOPLAYER_USEVDPAU))->SetDefault(!isIntel);
+#endif

   g_powerManager.SetDefaults();
 }
 
 void CSettings::InitializeOptionFillers()
