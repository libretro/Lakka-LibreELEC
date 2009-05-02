# Use shell variables, if defined
ifeq ($(PROJECT),)
export PROJECT=generic
endif

BUILD_DIRS="build.*"

all: system

system:
	./scripts/install image system

qemu:
	./scripts/install image qemu

clean:
	rm -rf $(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps
