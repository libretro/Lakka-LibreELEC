/* SPDX-License-Identifier: GPL-2.0 */
/* Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv) */

#include <sys/timex.h>
#include <unistd.h>
#include <errno.h>

int main()
{
  int rc;

  for (;;)
  {
    struct timex tx = {};

    rc = adjtimex(&tx);
    if (rc != TIME_ERROR)
      break;
    usleep(1000000U/3);
  }

  return rc == -1 ? errno : 0;
}
