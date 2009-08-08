#include <unistd.h>

int main(void) {
char *msg = "works\n";
return write(STDOUT_FILENO, msg, 6) != 6;
}