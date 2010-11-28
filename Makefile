BUILD_DIRS="build.*"

all: squashfs

system:
	./scripts/image

release:
	./scripts/image_release

squashfs:
	./scripts/image_squashfs

qemu:
	./scripts/image_qemu

vmware:
	./scripts/image_vmware

addons:
	./scripts/image_addons

clean:
	rm -rf $(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps
