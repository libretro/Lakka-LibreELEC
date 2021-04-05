
// Copyright 2021 David Guillen Fandos <david@davidgf.net>
// Under GPL 2 and 3 licenses

// Service that captures key events from one or several input devices and
// injects relevant events into Retroarch.
// This is mean to be used under Lakka or similar distributions.

#include <unistd.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <dirent.h>
#include <string.h>
#include <fcntl.h>
#include <poll.h>
#include <stdbool.h>
#include <time.h>
#include <sys/un.h>
#include <sys/socket.h>
#include <stddef.h>
#include <linux/input.h>

#define REPRESS_MS    350   // Automatically press the button again after 350ms
#define MAX_IDEVS       8

const char *event_map[KEY_MAX + 1] = {
  [0 ... KEY_MAX]  = NULL,
  [KEY_VOLUMEUP]   = "VOLUME_UP\n",
  [KEY_VOLUMEDOWN] = "VOLUME_DOWN\n",
  [KEY_MUTE]       = "MUTE\n",
};

static int dev_looks_valid(const struct dirent *dir) {
  return !memcmp("event", dir->d_name, 5);
}

static bool inlist(char **list, int count, const char *needle) {
  for (int j = 0; j < count; j++)
    if (!strcmp(list[j], needle))
      return true;
  return false;
}

static uint64_t gettimems() {
  struct timespec spec;
  clock_gettime(CLOCK_REALTIME, &spec);
  return ((uint64_t)spec.tv_sec) + (spec.tv_nsec / 1000000);
}

static int connectsocket() {
  int fd = socket(PF_UNIX, SOCK_STREAM, 0);
  if (fd < 0)
    return -1;

  const char *rapath = "retroarch/cmd";
  struct sockaddr_un addr;
  memset(&addr, 0, sizeof(addr));
  addr.sun_family = AF_UNIX;
  strcpy(&addr.sun_path[1], rapath);
  socklen_t addrsz = offsetof(struct sockaddr_un, sun_path) + strlen(rapath) + 1;
  if (connect(fd, (struct sockaddr *)&addr, addrsz) < 0) {
    close(fd);
    return -1;
  }
  return fd;
}

int main(int argc, char **argv) {
  int devfds[MAX_IDEVS];
  int numdevs = 0;
  signal(SIGPIPE, SIG_IGN);

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

      if (inlist(&argv[1], argc-1, devname))
        devfds[numdevs++] = fd;
      else
        close(fd);
    }
    if (numdevs)
      break;

    printf("Could not find any device, retrying in 10s ...\n");
    sleep(10);
  }

  // Assume all keys are unpressed by default
  uint64_t keystate[numdevs][KEY_MAX];
  memset(keystate, 0, sizeof(keystate));

  int clientfd = connectsocket();

  // Loop on events
  while (1) {
    struct pollfd fds[numdevs];
    for (int i = 0; i < numdevs; i++) {
      fds[i].fd = devfds[i];
      fds[i].events = POLLIN;
    }

    poll(fds, numdevs, -1);

    for (int i = 0; i < numdevs; i++) {
      if (fds[i].revents & POLLIN) {
        struct input_event ev[8];
        int readb = read(devfds[i], ev, sizeof(ev));
        if (readb < sizeof(struct input_event))
          return -1;    // Device is gone?

        for (unsigned j = 0; j < readb / sizeof(struct input_event); j++) {
          int keycode = ev[j].code;
          if (ev[j].type == EV_KEY && keycode < KEY_MAX) {
            // Just pressed now
            bool pressed = !keystate[i][keycode] && ev[j].value;
            // Has been pressed for more than 0.5 seconds
            bool longpressed = ev[j].value &&
                               (gettimems() - keystate[i][keycode]) > REPRESS_MS;
            if ((pressed || longpressed) && event_map[keycode]) {
              // Send command over the client socket
              int wr = write(clientfd, event_map[keycode], strlen(event_map[keycode]));
              // Reconnect on error!
              if (wr <= 0) {
                close(clientfd);
                clientfd = connectsocket();
              }
              // Record last pressed time (if button pressed, otherwise zero)
              keystate[i][keycode] = ev[j].value ? gettimems() : 0;
            }
          }
        }
      }
    }
  }
}


