default:
	obj-m += driver/aml_fd628.o
	$(MAKE) modules

FD628Service: FD628Service.c
	$(CC) $(CFLAGS) -Wall -w -o $@ $^ -lm -lpthread
