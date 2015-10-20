From 867d7535140dcf7b987ce86c3947c2ec5f5c7bd4 Mon Sep 17 00:00:00 2001
From: Stefan Saraev <stefan@saraev.ca>
Date: Mon, 18 Aug 2014 17:46:54 +0300
Subject: [PATCH 08/13] setup timezone

on TZ country setting change, store the value in format
TIMEZONE=Xx/Yyy to /storage/.cache/timezone to be used with
tz-data.service
---
 xbmc/linux/LinuxTimezone.cpp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/xbmc/linux/LinuxTimezone.cpp b/xbmc/linux/LinuxTimezone.cpp
index 7de8f8c..e278c6a 100644
--- a/xbmc/linux/LinuxTimezone.cpp
+++ b/xbmc/linux/LinuxTimezone.cpp
@@ -42,6 +42,8 @@
 
 #include <algorithm>
 
+#include <fstream>
+
 CLinuxTimezone::CLinuxTimezone() : m_IsDST(0)
 {
    char* line = NULL;
@@ -159,6 +161,16 @@ void CLinuxTimezone::OnSettingChanged(const CSetting *setting)
   const std::string &settingId = setting->GetId();
   if (settingId == CSettings::SETTING_LOCALE_TIMEZONE)
   {
+    std::ofstream out("/storage/.cache/timezone");
+    if (out)
+    {
+      const std::string tz = std::string("TIMEZONE=") + ((CSettingString*)setting)->GetValue().c_str();
+      out << tz << std::endl;
+      out.flush();
+      out.close();
+      system("systemctl restart tz-data.service");
+    }
+
     SetTimezone(((CSettingString*)setting)->GetValue());
 
     CDateTime::ResetTimezoneBias();
-- 
2.5.0

