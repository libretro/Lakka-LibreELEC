BUILD_DIRS=build.*

all: release

system:
	./scripts/image

release:
	./scripts/image release

image:
	./scripts/image mkimage

noobs:
	./scripts/image noobs

amlpkg:
	./scripts/image amlpkg

# legacy sequential build targets
system-st:
	./scripts/image_st

release-st:
	./scripts/image_st release

image-st:
	./scripts/image_st mkimage

noobs-st:
	./scripts/image_st noobs

amlpkg-st:
	./scripts/image_st amlpkg

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps

distclean:
	rm -rf ./.ccache ./$(BUILD_DIRS)

src-pkg:
	tar cvJf sources.tar.xz sources .stamps
