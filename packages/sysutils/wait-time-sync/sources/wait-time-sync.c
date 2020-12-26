/* SPDX-License-Identifier: GPL-2.0 */
/* Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv) */

#include <sys/timex.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <limits.h>

void usage(char *name)
{
  if (!name)
    name = "wait-time-sync";

  printf("Usage: %s [-t seconds | --timeout seconds]\n", name);
  exit(2);
}

int main(int argc, char** argv)
{
  unsigned timeout = UINT_MAX;
  int rc = 0;

  if (argc == 3)
  {
    unsigned long val;
    char *p;

    if (strcmp(argv[1], "-t") && strcmp(argv[1], "--timeout"))
      usage(argv[0]);
    val = strtoul(argv[2], &p, 0);
    if (*p || val == 0 || val >= UINT_MAX/3)
      usage(argv[0]);
    timeout = (unsigned)val * 3;
  }
  else if (argc != 1)
    usage(argv[0]);

  for ( ; timeout; --timeout)
  {
    struct timex tx = {};

    rc = adjtimex(&tx);
    if (rc != TIME_ERROR)
      break;
    usleep(1000000U/3);
  }

  return rc == -1 ? errno : !timeout;
}
