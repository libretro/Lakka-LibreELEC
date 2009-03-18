/*
 * D-BUS/HAL based volume automounter for GeeXboX
 *
 * Copyright (C) 2008 Benjamin Zores
 *
 * This file is part of GeeXboX.
 *
 * GeeXboX is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * GeeXboX is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with GeeXboX; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>

#include <glib.h>
#include <dbus/dbus.h>
#include <dbus/dbus-glib.h>
#include <dbus/dbus-glib-lowlevel.h>
#include <libhal.h>
#include <libhal-storage.h>

typedef struct volume_s {
  char *device;
  char *name;
  char *type;
  char *fstype;
} volume_t;

static const struct {
  const char *name;
  LibHalDriveBus bus;
} drv_bus_mapping[] = {
  { "Unknown",                LIBHAL_DRIVE_BUS_UNKNOWN                  },
  { "IDE",                    LIBHAL_DRIVE_BUS_IDE                      },
  { "SATA",                   LIBHAL_DRIVE_BUS_SCSI                     },
  { "USB",                    LIBHAL_DRIVE_BUS_USB                      },
  { "FireWire",               LIBHAL_DRIVE_BUS_IEEE1394                 },
  { "CCW",                    LIBHAL_DRIVE_BUS_CCW                      },
  { NULL,                     0                                         }
};

static const struct {
  const char *name;
  LibHalDriveType type;
} drv_type_mapping[] = {
  { "Removable Disk",         LIBHAL_DRIVE_TYPE_REMOVABLE_DISK          },
  { "Disk",                   LIBHAL_DRIVE_TYPE_DISK                    },
  { "CD-ROM",                 LIBHAL_DRIVE_TYPE_CDROM                   },
  { "Floppy",                 LIBHAL_DRIVE_TYPE_FLOPPY                  },
  { "Tape",                   LIBHAL_DRIVE_TYPE_TAPE                    },
  { "CompactFlash",           LIBHAL_DRIVE_TYPE_COMPACT_FLASH           },
  { "MemoryStick",            LIBHAL_DRIVE_TYPE_MEMORY_STICK            },
  { "SmartMedia",             LIBHAL_DRIVE_TYPE_SMART_MEDIA             },
  { "SD/MMC",                 LIBHAL_DRIVE_TYPE_SD_MMC                  },
  { "Camera",                 LIBHAL_DRIVE_TYPE_CAMERA                  },
  { "Portable Audio Player",  LIBHAL_DRIVE_TYPE_PORTABLE_AUDIO_PLAYER   },
  { "ZIP",                    LIBHAL_DRIVE_TYPE_ZIP                     },
  { "JAZ",                    LIBHAL_DRIVE_TYPE_JAZ                     },
  { "FlashKey",               LIBHAL_DRIVE_TYPE_FLASHKEY                },
  { "MagnetoOptical",         LIBHAL_DRIVE_TYPE_MO                      },
  { NULL,                     0                                         }
};

static const struct {
  const char *name;
  const char *property;
} vol_disc_mapping[] = {
  { "CDDA",                   "volume.disc.has_audio"                   },
  { "VCD",                    "volume.disc.is_vcd"                      },
  { "SVCD",                   "volume.disc.is_svcd"                     },
  { "DVD",                    "volume.disc.is_videodvd"                 },
  { "CD",                     "volume.disc.has_data"                    },
  { NULL,                     NULL                                      }
};

static GMainLoop *loop;
static GHashTable *devices;
static LibHalContext *ctx;
static DBusError error;

static volume_t *
volume_new (void)
{
  volume_t *v;

  v = calloc (1, sizeof (volume_t));

  return v;
}

static void
volume_free (volume_t *v)
{
  if (!v)
    return;

  if (v->device)
    free (v->device);
  if (v->name)
    free (v->name);
  if (v->type)
    free (v->type);
  if (v->fstype)
    free (v->fstype);
  free (v);
}

static void
volume_append_name (volume_t *v, char *str)
{
  char mp[1024];

  if (!v || !str)
    return;

  if (!v->name)
    v->name = strdup (str);
  else
  {
    memset (mp, '\0', sizeof (mp));
    snprintf (mp, sizeof (mp), "%s %s", v->name, str);
    free (v->name);
    v->name = strdup (mp);
  }
}

static void
volume_add (volume_t *v, const char *udi)
{
  char cmd[1024];

  if (!v || !udi)
    return;

  g_hash_table_insert (devices, (gpointer) strdup (udi), (gpointer) v);

  memset (cmd, '\0', sizeof (cmd));
  snprintf (cmd, sizeof (cmd), "/usr/bin/hmount '%s' '%s' '%s' '%s'",
            v->type, v->device, v->name, v->fstype);

  printf ("[automountd] Executing: %s\n", cmd);
  system (cmd);
}

static void
volume_remove (const char *udi)
{
  volume_t *v;
  char cmd[1024];

  if (!udi)
    return;

  v = g_hash_table_lookup (devices, udi);
  if (!v)
    return;

  memset (cmd, '\0', sizeof (cmd));
  snprintf (cmd, sizeof (cmd), "/usr/bin/humount '%s' '%s' '%s' '%s'",
            v->type, v->device, v->name, v->fstype);

  printf ("[automountd] Executing: %s\n", cmd);
  system (cmd);
  g_hash_table_remove (devices, udi);
}

static int
disk_get_number (int major, int minor)
{
  switch (major)
  {
  case 3: /* Primary IDE interface */
    return (minor <= 63) ? 1 : 2;
  case 8: /* SCSI disk devices */
    return ((minor / 16) + 1);
  case 11: /* SCSI CD-ROM devices */
    return (minor + 1);
  case 22: /* Secondary IDE interface */
    return (minor <= 63) ? 3 : 4;
  default:
    break;
  }

  return 0;
}

static void
add_hdd (LibHalVolume *vol, const char *udi)
{
  volume_t *v;
  LibHalDrive *drv;
  LibHalDriveType type;
  LibHalDriveBus bus;
  LibHalVolumeUsage usage;
  const char *parent_udi;
  char disk[4], part[16];
  int i, nb;

  if (!vol || !udi)
    return;

  /* check if it's actually a mountable filesystem */
  usage = libhal_volume_get_fsusage (vol);
  if (usage != LIBHAL_VOLUME_USAGE_MOUNTABLE_FILESYSTEM)
    return;

  /* if partition is already mounted, we're done */
  if (libhal_volume_is_mounted (vol))
    return;

  /* get volume's storage udi */
  parent_udi = libhal_volume_get_storage_device_udi (vol);
  if (!parent_udi)
    return;

  drv = libhal_drive_from_udi (ctx, parent_udi);
  if (!drv)
    return;

  v = volume_new ();
  v->device = strdup (libhal_volume_get_device_file (vol));
  v->type = strdup ("HDD"); /* always the case for partitions */
  v->fstype = strdup (libhal_volume_get_fstype (vol));

  type = libhal_drive_get_type (drv);
  bus = libhal_drive_get_bus (drv);

  /* get bus' type */
  for (i = 0; drv_bus_mapping[i].name; i++)
    if (drv_bus_mapping[i].bus == bus)
    {
      volume_append_name (v, (char *) drv_bus_mapping[i].name);
      break;
    }

  /* append disk's number to differenciate twice the same hardware */
  nb = disk_get_number (libhal_volume_get_device_major (vol),
                        libhal_volume_get_device_minor (vol));
  memset (disk, '\0', sizeof (disk));
  snprintf (disk, sizeof (disk), "#%d", nb);
  volume_append_name (v, disk);

  /* get drive's type */
  for (i = 0; drv_type_mapping[i].name; i++)
    if (drv_type_mapping[i].type == type)
    {
      volume_append_name (v, (char *) drv_type_mapping[i].name);
      break;
    }

  /* either use partition label if any or vendor/model couple otherwise */
  if (libhal_volume_get_label (vol))
    volume_append_name (v, (char *) libhal_volume_get_label (vol));
  else
  {
    if (libhal_drive_get_vendor (drv))
      volume_append_name (v, (char *) libhal_drive_get_vendor (drv));
    if (libhal_drive_get_model (drv))
      volume_append_name (v, (char *) libhal_drive_get_model (drv));
  }

  /* append partition's number to identify multiple partitions on same drive */
  memset (part, '\0', sizeof (part));
  snprintf (part, sizeof (part), "(%d)",
            libhal_volume_get_partition_number (vol));
  volume_append_name (v, part);

  libhal_drive_free (drv);

  /* add volume to global list of devices */
  volume_add (v, udi);
}

static void
add_disc (LibHalVolume *vol, const char *udi)
{
  volume_t *v;
  LibHalDrive *drv;
  LibHalDriveBus bus;
  const char *parent_udi;
  char cd[4];
  int i, nb;

  if (!vol || !udi)
    return;

  /* discard blank CDs */
  if (libhal_volume_disc_is_blank (vol))
    return;

  /* get volume's storage udi */
  parent_udi = libhal_volume_get_storage_device_udi (vol);
  if (!parent_udi)
    return;

  drv = libhal_drive_from_udi (ctx, parent_udi);
  if (!drv)
    return;

  v = volume_new ();
  v->device = strdup (libhal_volume_get_device_file (vol));

  /* get bus' type */
  bus = libhal_drive_get_bus (drv);
  for (i = 0; drv_bus_mapping[i].name; i++)
    if (drv_bus_mapping[i].bus == bus)
    {
      volume_append_name (v, (char *) drv_bus_mapping[i].name);
      break;
    }

  /* append disk's number to differenciate twice the same hardware */
  nb = disk_get_number (libhal_volume_get_device_major (vol),
                        libhal_volume_get_device_minor (vol));
  memset (cd, '\0', sizeof (cd));
  snprintf (cd, sizeof (cd), "#%d", nb);
  volume_append_name (v, cd);

  /* check for disc property: CDDA, VCD, SVCD, DVD, Data CD/DVD */
  for (i = 0; vol_disc_mapping[i].name; i++)
    if (libhal_device_property_exists (ctx, udi,
                                       vol_disc_mapping[i].property,
                                       &error))
    {
      if (libhal_device_get_property_bool (ctx, udi,
                                           vol_disc_mapping[i].property,
                                           &error))
      {
        v->type = strdup (vol_disc_mapping[i].name);
        volume_append_name (v, (char *) vol_disc_mapping[i].name);
        break;
      }
    }

  /* if no type has been found, consider it's data */
  if (!v->type)
    v->type = strdup ("CD");

  /* if disc contains data and is already mounted, we're done */
  if ((strcmp (v->type, "CDDA") != 0) && (strcmp (v->type, "DVD") != 0))
  {
    if (libhal_volume_is_mounted (vol))
    {
      libhal_drive_free (drv);
      volume_free (v);
      return;
    }
  }

  /* either use partition label if any or vendor/model couple otherwise */
  if (libhal_volume_get_label (vol))
    volume_append_name (v, (char *) libhal_volume_get_label (vol));
  else
  {
    if (libhal_drive_get_vendor (drv))
      volume_append_name (v, (char *) libhal_drive_get_vendor (drv));
    if (libhal_drive_get_model (drv))
      volume_append_name (v, (char *) libhal_drive_get_model (drv));
  }

  /* we need to explicitely unlock the device to ensure it can be ejected */
  libhal_device_unlock (ctx, udi, NULL);

  /* add volume to global list of devices */
  volume_add (v, udi);

  libhal_drive_free (drv);
}

static void
check_hal_volume (const char *udi)
{
  LibHalVolume *vol;
  volume_t *v;

  /* do we already know this device ?*/
  v = g_hash_table_lookup (devices, udi);
  if (v)
    return;

  /* is it actually an HAL volume ? */
  vol = libhal_volume_from_udi (ctx, udi);
  if (!vol)
    return;

  if (libhal_volume_is_disc (vol))
    add_disc (vol, udi);
  else
    add_hdd (vol, udi);

  libhal_volume_free (vol);
}

static void
cb_device_added (LibHalContext *ctx, const char *udi)
{
  check_hal_volume (udi);
}

static void
cb_device_removed (LibHalContext *ctx, const char *udi)
{
  volume_remove (udi);
}

static void
signal_handler (int sig)
{
  g_main_loop_quit (loop);
}

int
main (int argc, char **argv)
{
  DBusConnection *conn;
  char **device_list;
  int num_devices;
  int i;

  if (argc >= 2 && !strcmp (argv[1], "-d"))
    daemon (0, 0);

  /* connect to D-BUS */
  dbus_error_init (&error);
  conn = dbus_bus_get (DBUS_BUS_SYSTEM, &error);
  if (!conn)
    goto dbus_error;

  /* create HAL context */
  ctx = libhal_ctx_new ();
  if (!ctx)
    goto hal_error;

  /* build global list of handled devices */
  devices = g_hash_table_new_full (g_str_hash, g_str_equal,
                                   free, (GDestroyNotify) volume_free);

  /* bind HAL to D-BUS */
  dbus_connection_setup_with_g_main (conn, NULL);
  libhal_ctx_set_dbus_connection (ctx, conn);

  /* set HAL callbacks */
  libhal_ctx_set_device_added (ctx, cb_device_added);
  libhal_ctx_set_device_removed (ctx, cb_device_removed);

  /* init HAL */
  libhal_ctx_init (ctx, &error);
  libhal_device_property_watch_all (ctx, &error);

  /* browse all currently available HAL devices */
  device_list = libhal_get_all_devices (ctx, &num_devices, &error);
  for (i = 0; i < num_devices; i++)
    check_hal_volume (device_list[i]);

  /* catch signals */
  signal (SIGTERM, signal_handler);
  signal (SIGINT, signal_handler);

  /* start GLib main loop */
  loop = g_main_loop_new (NULL, FALSE);
  g_main_loop_run (loop);

  /* ends up ... */
  g_hash_table_destroy (devices);
  libhal_ctx_shutdown (ctx, &error);
  libhal_ctx_free (ctx);

 hal_error:
  dbus_connection_unref (conn);
  dbus_error_free (&error);

 dbus_error:

  return 0;
}
