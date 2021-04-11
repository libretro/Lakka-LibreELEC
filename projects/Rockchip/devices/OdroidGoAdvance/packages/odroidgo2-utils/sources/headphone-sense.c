
// Copyright 2021 David Guillen Fandos <david@davidgf.net>
// Under GPL 2 and 3 licenses

// Service that senses an input device for events (related to headphone status)
// and triggers events related to audio mixer.
// This is used in the OGA devices to switch between spaker and jack.

#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <fcntl.h>
#include <poll.h>
#include <stddef.h>
#include <linux/input.h>

static int dev_looks_valid(const struct dirent *dir) {
  return !memcmp("event", dir->d_name, 5);
}

static void update_alsa(int state) {
  if (state)
    system("amixer cset name='Playback Path' SPK");
  else
    system("amixer cset name='Playback Path' HP");
}

int main(int argc, char **argv) {
  int sensefd = -1;

  if (argc < 2) {
    printf("Missing argv[1]!\n");
    return 1;
  }

  while (1) {
    // Scan devices to find relevant devices
    struct dirent **namelist;
    int num = scandir("/dev/input", &namelist, dev_looks_valid, NULL);
    for (int i = 0; i < num; i++) {
      char path[PATH_MAX] = "/dev/input/";
      strcat(path, namelist[i]->d_name);
      int fd = open(path, O_RDONLY);
      if (fd < 0)
        continue;

      // Get the device name
      char devname[512];
      ioctl(fd, EVIOCGNAME(sizeof(devname)), devname);

      if (!strcmp(argv[1], devname))
        sensefd = fd;
      else
        close(fd);
    }
    if (sensefd >= 0)
      break;

    printf("Could not find the device, retrying in 10s ...\n");
    sleep(10);
  }

  // Query initial key state
  unsigned int state = 0;
  if (ioctl(sensefd, EVIOCGSW(sizeof(state)), &state) >= 0) {
    update_alsa(state & (1 << SW_HEADPHONE_INSERT));
  }

  // Loop on events
  while (1) {
    struct input_event ev[8];
    int readb = read(sensefd, ev, sizeof(ev));
    if (readb <= sizeof(struct input_event))
      return -1;    // Device is gone?

    for (unsigned j = 0; j < readb / sizeof(struct input_event); j++) {
      int keycode = ev[j].code;
      if (ev[j].type == EV_SW && keycode == SW_HEADPHONE_INSERT) {
        // Check value and execute the right command
        update_alsa(ev[j].value);
      }
    }
  }
}


