/*
 * (C) Copyright 2016 Jernej Škrabec <jernej.skrabec@siol.net>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/*
 * Definitions are taken from arch/arch/mach-sunxi/include/mach/sys_config.h
 * which is released under GPL2+ and has following copyrights:
 * (C) Copyright 2010-2015
 * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
 * Kevin <Kevin@allwinnertech.com>
 */

struct gpio_config {
  uint32_t gpio;
  uint32_t mul_sel;
  uint32_t pull;
  uint32_t drv_level;
  uint32_t data;
};

enum {
  SCIRPT_ITEM_VALUE_TYPE_INVALID = 0,
  SCIRPT_ITEM_VALUE_TYPE_INT,
  SCIRPT_ITEM_VALUE_TYPE_STR,
  SCIRPT_ITEM_VALUE_TYPE_PIO,
};

typedef union {
    int                 val;
    char                *str;
    struct gpio_config  gpio;
} script_item_u;

const char *scriptfile = "/sys/class/script/get_item";

int main(int argc, char** argv)
{
  FILE *pFile;
  script_item_u item;
  size_t count;
  uint32_t type;
  int res = 0;
  char buffer[1024];
  
  if (argc != 3)
    return -1;
  
  pFile = fopen(scriptfile, "w");
  if (pFile == NULL)
    return -1;
  
  if (fprintf(pFile, "%s %s", argv[1], argv[2]) < 0) {
    fclose(pFile);
    return -1;
  }
    
  fclose(pFile);

  pFile = fopen(scriptfile, "rb");
  if (pFile == NULL)
    return -1;

  count = fread(&item, 1, sizeof(item), pFile);
  if (count != sizeof(item)) {
    fclose(pFile);
    return -1;
  }
  
  count = fread(&type, 1, sizeof(type), pFile);
  if (count != sizeof(type)) {
    fclose(pFile);
    return -1;
  }

  switch (type) {
    case SCIRPT_ITEM_VALUE_TYPE_INT:
      printf("%d", item.val);
      break;
    case SCIRPT_ITEM_VALUE_TYPE_STR:
      while ((count = fread(buffer, 1, sizeof(buffer) - 1, pFile)) > 0) {
        if (ferror(pFile)) {
          res = -1;
          break;
        }
        buffer[count] = '\0';
        printf("%s", buffer);
      }
      break;
    default:
      res = -1;
      break;
  }

  fclose(pFile);
  
  return res;
}