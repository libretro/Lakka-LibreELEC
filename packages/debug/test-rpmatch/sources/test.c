#define _SVID_SOURCE
#include <locale.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int
main(int argc, char *argv[])
{
    if (argc != 2 || strcmp(argv[1], "--help") == 0) {
        fprintf(stderr, "%s response", argv[0]);
        exit(EXIT_FAILURE);
    }

    setlocale(LC_ALL, "");
    printf("rpmatch() returns: %d", rpmatch(argv[1]));
    exit(EXIT_SUCCESS);
}

