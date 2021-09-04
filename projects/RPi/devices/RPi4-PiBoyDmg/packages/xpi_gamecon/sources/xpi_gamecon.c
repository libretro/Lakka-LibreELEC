#include <linux/delay.h>
#include <linux/input.h>
#include <linux/of_device.h>
#include <linux/module.h>
#include <linux/slab.h>

#include <asm/io.h>

MODULE_AUTHOR("Nathan Scherdin");
MODULE_DESCRIPTION("PiBoy DMG Controls driver");
MODULE_LICENSE("GPL");

static struct gc *gc_base;
static const int gc_gpio_clk = 26;
static const int gc_gpio_data = 27;
static const int gc_clk_bit = 1<<26;
static const int gc_data_bit = 1<<27;

static unsigned long lastgood=0;
static unsigned long lasterror=0;

static uint8_t index;

union {
	struct {
		int flags_val;
		int fan_val;
		int red_val;
		int green_val;
	};
	int data[4];
}volatile values;

volatile int version_val = 0;
volatile int cur_val = 0;
volatile int batt_val = 0;
volatile int percent_val = 0;
volatile int stat_val = 0;
volatile int vol_val = 0;

struct kobject *kobj_ref;

#define GC_LENGTH 12

#define GPIO_SET *(gpio+7)
#define GPIO_CLR *(gpio+10)
#define GPIO_STATUS (*(gpio+13))

#define GC_REFRESH_TIME	(HZ/120)

#define BITRATE 7

static volatile unsigned *gpio;

static const short gc_btn[] = { BTN_A, //A
				BTN_B, //B
				BTN_C, //C
				BTN_X, //X
				BTN_Y, //Y
				BTN_Z, //Z
				BTN_SELECT, //Select
				BTN_START, //Start
				BTN_THUMBL, //Left Thumb
				BTN_DPAD_UP, //DPAD Up
				BTN_DPAD_DOWN, //DPAD Down
				BTN_DPAD_LEFT, //DPAD Left
				BTN_DPAD_RIGHT, //DPAD Right
				BTN_TL, //Left Trigger
				BTN_TR, //Right Trigger
			};
int gc_btn_size = sizeof(gc_btn);

struct gc {
	struct input_dev *dev;
	struct timer_list timer;
	int used;
	struct mutex mutex;
};

static ssize_t version_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", version_val); }
static ssize_t version_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&version_val); return count; }

static ssize_t flags_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", values.flags_val); }
static ssize_t flags_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&values.flags_val); return count; }

static ssize_t red_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", values.red_val); }
static ssize_t red_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&values.red_val); return count; }

static ssize_t green_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", values.green_val); }
static ssize_t green_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&values.green_val); return count; }

static ssize_t fan_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", values.fan_val); }
static ssize_t fan_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&values.fan_val); return count; }

static ssize_t cur_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", cur_val); }
static ssize_t cur_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&cur_val); return count; }

static ssize_t batt_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", batt_val); }
static ssize_t batt_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&batt_val); return count; }

static ssize_t percent_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", percent_val); }
static ssize_t percent_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&percent_val); return count; }

static ssize_t stat_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", stat_val); }
static ssize_t stat_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&stat_val); return count; }

static ssize_t vol_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf){ return sprintf(buf, "%d", vol_val); }
static ssize_t vol_store(struct kobject *kobj, struct kobj_attribute *attr,const char *buf, size_t count) { sscanf(buf,"%d",&vol_val); return count; }

struct kobj_attribute version = __ATTR(version, 0440, version_show, version_store);
struct kobj_attribute flags = __ATTR(flags, 0660, flags_show, flags_store);
struct kobj_attribute red = __ATTR(red, 0660, red_show, red_store);
struct kobj_attribute green = __ATTR(green, 0660, green_show, green_store);
struct kobj_attribute fan = __ATTR(fan, 0660, fan_show, fan_store);
struct kobj_attribute cur = __ATTR(amps, 0660, cur_show, cur_store);
struct kobj_attribute batt = __ATTR(battery, 0660, batt_show, batt_store);
struct kobj_attribute per = __ATTR(percent, 0660, percent_show, percent_store);
struct kobj_attribute stat = __ATTR(status, 0660, stat_show, stat_store);
struct kobj_attribute vol = __ATTR(volume, 0660, vol_show, vol_store);

void gpio_func(int pin, int state)
{
	volatile unsigned *tgpio = gpio;
	tgpio += (pin/10);
	if(state){*tgpio &= ~(0x7<<(pin%10)*3);	}
	else{*tgpio |= (0x1<<(pin%10)*3);}
}

uint16_t check_crc16(uint8_t data[])
{
	int len = GC_LENGTH-2;
	uint16_t crc=0;
	uint16_t ccrc = (data[GC_LENGTH-1]<<8) | data[GC_LENGTH-2];
	int i,j;

	for(i = 0;i<len;i++){
		crc = (uint16_t)(crc ^ ((uint16_t)data[i] << 8));
		for (j=0; j<8; j++){
			if ((crc & 0x8000)!=0) crc = (uint16_t)((crc << 1) ^ 0x1021);
			else crc <<= 1;
		}
	}

	return crc==ccrc ? 0 : 1;
}

uint16_t crc=0;
void calc_crc16(uint8_t *data, uint8_t len)
{
	int i,j;

	crc=0;

	for(i = 0;i<len;i++){
		crc = (uint16_t)(crc ^ ((uint16_t)data[i] << 8));
		for (j=0; j<8; j++){
			if ((crc & 0x8000)!=0) crc = (uint16_t)((crc << 1) ^ 0x1021);
			else crc <<= 1;
		}
	}
	data[len] = crc>>8;
	data[len+1] = crc&0xFF;
}

static void gc_timer(struct timer_list *t)
{
	struct gc *gc = from_timer(gc, t, timer);

	unsigned char data[32];
	struct input_dev *dev = gc->dev;

	int byteindex;
	long bitindex;

	gpio_func(gc_gpio_data,1);	//input

	for(byteindex=0;byteindex<GC_LENGTH;byteindex++){
		data[byteindex]=0;
		for(bitindex=0;bitindex<8;bitindex++){
			data[byteindex]<<=1;

			//set clock pin
			GPIO_SET |= gc_clk_bit;
			udelay(BITRATE);
			GPIO_CLR |= gc_clk_bit;
			udelay(BITRATE);
			data[byteindex] |= GPIO_STATUS & gc_data_bit ? 1 : 0;
		}
	}

	gpio_func(gc_gpio_data,0);	//output

	GPIO_SET |= gc_clk_bit;
	udelay(BITRATE);
	GPIO_CLR |= gc_clk_bit;
	udelay(BITRATE);

	if(data[0] && !check_crc16(data)){
		uint8_t len = 0;
		if(data[0]==0xA5){
			unsigned char val;
			len = 2;
			version_val = 0x0100;
			val = values.fan_val | (values.flags_val&0x1 ? 0x00 : 0x80);
			data[GC_LENGTH] = val;
			data[GC_LENGTH+1] = ~val;
			data[GC_LENGTH+2] = 0;
			data[GC_LENGTH+3] = 0;
		}
		else
		if(data[0]==0x5A){
			len = 4;
			version_val = 0x0101;
			data[GC_LENGTH+0] = 0xC0 | (index&0x3);
			data[GC_LENGTH+1] = values.data[index&0x3];
			calc_crc16(&data[GC_LENGTH],2);
			index++;
		}
		else{
			len = 4;
			version_val = ((data[0]&0xC0)<<2) | (data[0]&0x3F);
			data[GC_LENGTH+0] = 0xC0 | (index&0x3);
			data[GC_LENGTH+1] = values.data[index&0x3];
			calc_crc16(&data[GC_LENGTH],2);
			index++;
		}

		for(byteindex=GC_LENGTH;byteindex<GC_LENGTH+len;byteindex++){
			for(bitindex=0;bitindex<8;bitindex++){
				if(data[byteindex]&(0x80>>bitindex))
					GPIO_SET |= gc_data_bit;
				else
					GPIO_CLR |= gc_data_bit;
				//set clock pin
				GPIO_SET |= gc_clk_bit;
				udelay(BITRATE);
				GPIO_CLR |= gc_clk_bit;
				udelay(BITRATE);
			}
		}

		lastgood++;

		input_report_abs(dev, ABS_X, (int16_t)data[1]);		//X Axis
		input_report_abs(dev, ABS_Y, (int16_t)data[2]);		//Y Axis

		input_report_key(dev, gc_btn[0], !(data[3]&0x01));	//A
		input_report_key(dev, gc_btn[1], !(data[3]&0x02));	//B
		input_report_key(dev, gc_btn[2], !(data[3]&0x04));	//C
		input_report_key(dev, gc_btn[3], !(data[3]&0x08));	//X
		input_report_key(dev, gc_btn[4], !(data[3]&0x10));	//Y
		input_report_key(dev, gc_btn[5], !(data[3]&0x20));	//Z
		input_report_key(dev, gc_btn[6], data[3]&0x40);		//Select
		input_report_key(dev, gc_btn[7], data[3]&0x80); 	//Start
		input_report_key(dev, gc_btn[8], data[4]&0x40);		//Left Thumb
		input_report_key(dev, gc_btn[9], data[4]&0x01);		//DPAD Up
		input_report_key(dev, gc_btn[10], data[4]&0x02);	//DPAD Down
		input_report_key(dev, gc_btn[11], data[4]&0x04);	//DPAD Left
		input_report_key(dev, gc_btn[12], data[4]&0x08);	//DPAD Right
		input_report_key(dev, gc_btn[13], data[4]&0x10);	//Left Shoulder
		input_report_key(dev, gc_btn[14], data[4]&0x20);	//Right Shoulder

		input_sync(dev);

		batt_val = (int)(data[7]*5)+2950;		//Battery Voltage
		cur_val = (int)((signed char)data[8])*50;	//Current
		percent_val = data[9];				//battery percentage
		stat_val = data[5]&0xC6;			//VBus,Shutdown,VSTAT2,VSTAT1
		vol_val = data[6];				//Volume

		lasterror = 0;
	}
	else{
		lasterror++;
		printk(KERN_INFO "XPi Gamecon CRC Error: %4.4lu %4.4lu",lastgood,lasterror);
		//printk(KERN_INFO "XPi Gamecon CRC Error: %4.4lu %4.4lu %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x %2.2x",
		//	lastgood,lasterror, 
		//	data[0],data[1],data[2],data[3],
		//	data[4],data[5],data[6],data[7],
		//	data[8],data[9],data[10],data[11],
		//	data[12],data[13],data[14],data[15]);
		lastgood=0;
	}

	gpio_func(gc_gpio_data,1);	//input

	mod_timer(&gc->timer, jiffies + GC_REFRESH_TIME);
}

static int __init gc_setup_pad(struct gc *gc)
{
	struct input_dev *input_dev;
	int i;
	int err;

	gc->dev = input_dev = input_allocate_device();
	if (!input_dev) {
		printk(KERN_INFO "Not enough memory for input device\n");
		return -ENOMEM;
	}

	input_dev->name = "PiBoy DMG Controller";
	input_dev->phys = "input0";
	input_dev->id.bustype = BUS_PARPORT;
	input_dev->id.vendor = 0x0001;
	input_dev->id.product = 1;
	input_dev->id.version = 0x0100;

	input_set_drvdata(input_dev, gc);

	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);

	for (i = 0; i < gc_btn_size; i++){
		__set_bit(gc_btn[i], input_dev->keybit);
	}

	input_set_abs_params(input_dev, ABS_X, 0, 255, 0, 0);
	input_set_abs_params(input_dev, ABS_Y, 0, 255, 0, 0);

	err = input_register_device(input_dev);
	if (err)
		goto err_free_dev;

	/* set data pin to input */
	gpio_func(gc_gpio_clk,0);	//output
	gpio_func(gc_gpio_data,1);	//input

	printk(KERN_INFO "GPIO%i and GPIO%i configured for Piboy DMG controller pins\n",gc_gpio_clk,gc_gpio_data);
	printk(KERN_INFO "PiBoy DMG Controls module loaded");

	return 0;

err_free_dev:
	input_free_device(gc->dev);
	gc->dev = NULL;
	return err;
}

static struct gc __init *gc_probe(void)
{
	struct gc *gc;
	int err;

	gc = kzalloc(sizeof(struct gc), GFP_KERNEL);
	if (!gc) {
		printk(KERN_INFO "Not enough memory\n");
		err = -ENOMEM;
		goto err_out;
	}

	mutex_init(&gc->mutex);

	timer_setup(&gc->timer, gc_timer, 0);

	err = gc_setup_pad(gc);
	if (err) goto err_unreg_devs;
	return gc;

 err_unreg_devs:
	if (gc->dev) input_unregister_device(gc->dev);
	kfree(gc);
 err_out:
	return ERR_PTR(err);
}

static void gc_remove(struct gc *gc)
{
	if (gc->dev)
		input_unregister_device(gc->dev);
	kfree(gc);
}

/**
 * gc_bcm_peri_base_probe - Find the peripherals address base for
 * the running Raspberry Pi model. It needs a kernel with runtime Device-Tree
 * overlay support.
 *
 * Based on the userland 'bcm_host' library code from
 * https://github.com/raspberrypi/userland/blob/2549c149d8aa7f18ff201a1c0429cb26f9e2535a/host_applications/linux/libs/bcm_host/bcm_host.c#L150
 *
 * Reference: https://www.raspberrypi.org/documentation/hardware/raspberrypi/peripheral_addresses.md
 *
 * If any error occurs reading the device tree nodes/properties, then return 0.
 */
static u32 __init gc_bcm_peri_base_probe(void) {

	char *path = "/soc";
	struct device_node *dt_node;
	u32 base_address = 1;

	dt_node = of_find_node_by_path(path);
	if (!dt_node) {
		printk(KERN_INFO "failed to find device-tree node: %s\n", path);
		return 0;
	}

	if (of_property_read_u32_index(dt_node, "ranges", 1, &base_address)) {
		printk(KERN_INFO "failed to read range index 1\n");
		return 0;
	}

	if (base_address == 0) {
		if (of_property_read_u32_index(dt_node, "ranges", 2, &base_address)) {
			printk(KERN_INFO "failed to read range index 2\n");
			return 0;
		}
	}

	return base_address == 1 ? 0x02000000 : base_address;
}

void osd(void)
{
	char *envp[] = {
	    "SHELL=/bin/bash",
	    "HOME=/",
	    "USER=root",
	    "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
	    "DISPLAY=:0",
	    "PWD=/",
	    NULL
	};

	char *argv[] = { "/home/pi/osd/osd", NULL };
	int result = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
	printk(KERN_INFO "Executing OSD: %i",result);
}

static int __init gc_init(void)
{
	/* BCM board peripherals address base */
	static u32 gc_bcm2708_peri_base;

	values.flags_val = 1;
	values.fan_val = 10;
	values.red_val = 100;
	values.green_val = 100;

	osd();

	/* Get the BCM2708 peripheral address */
	gc_bcm2708_peri_base = gc_bcm_peri_base_probe();
	if (!gc_bcm2708_peri_base) {
		printk(KERN_INFO "failed to find peripherals address base via device-tree\n");
		return -ENODEV;
	}

	printk(KERN_INFO "peripherals address base at 0x%08x\n", gc_bcm2708_peri_base);

	/* Set up gpio pointer for direct register access */
   	if ((gpio = ioremap((gc_bcm2708_peri_base + 0x200000), 0xB0)) == NULL) {
   	   	printk(KERN_INFO "io remap failed\n");
   	   	return -EBUSY;
   	}

	gc_base = gc_probe();
	if (IS_ERR(gc_base))
		return -ENODEV;

	/*Creating a directory in /sys/kernel/ */
	kobj_ref = kobject_create_and_add("xpi_gamecon",kernel_kobj);

	if(sysfs_create_file(kobj_ref,&version.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&flags.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&red.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&green.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&fan.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&cur.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&batt.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&per.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&stat.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}
	if(sysfs_create_file(kobj_ref,&vol.attr)){
		printk(KERN_INFO "Cannot create sysfs file......\n");
		goto r_sysfs;
	}

	printk(KERN_INFO "Device Driver Insert...Done!!!\n");

	mod_timer(&gc_base->timer, jiffies + GC_REFRESH_TIME);

	return 0;

r_sysfs:
	kobject_put(kobj_ref);
	sysfs_remove_file(kernel_kobj, &vol.attr);
	sysfs_remove_file(kernel_kobj, &stat.attr);
	sysfs_remove_file(kernel_kobj, &per.attr);
	sysfs_remove_file(kernel_kobj, &batt.attr);
	sysfs_remove_file(kernel_kobj, &cur.attr);
	sysfs_remove_file(kernel_kobj, &fan.attr);
	sysfs_remove_file(kernel_kobj, &green.attr);
	sysfs_remove_file(kernel_kobj, &red.attr);
	sysfs_remove_file(kernel_kobj, &flags.attr);
	sysfs_remove_file(kernel_kobj, &version.attr);

	if (gc_base)
		gc_remove(gc_base);

	iounmap(gpio);

        return -1;
}

static void __exit gc_exit(void)
{
	if (gc_base){
		del_timer_sync(&gc_base->timer);
		gc_remove(gc_base);
	}

	iounmap(gpio);

	kobject_put(kobj_ref);
	sysfs_remove_file(kernel_kobj, &vol.attr);
	sysfs_remove_file(kernel_kobj, &stat.attr);
	sysfs_remove_file(kernel_kobj, &per.attr);
	sysfs_remove_file(kernel_kobj, &batt.attr);
	sysfs_remove_file(kernel_kobj, &cur.attr);
	sysfs_remove_file(kernel_kobj, &fan.attr);
	sysfs_remove_file(kernel_kobj, &green.attr);
	sysfs_remove_file(kernel_kobj, &red.attr);
	sysfs_remove_file(kernel_kobj, &flags.attr);
	sysfs_remove_file(kernel_kobj, &version.attr);

	printk(KERN_INFO "PiBoy DMG Controls module unloaded");
}

module_init(gc_init);
module_exit(gc_exit);
