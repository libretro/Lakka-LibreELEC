BUILD_DIRS="build.*"

all: system

system:
	./scripts/install image system
	./scripts/install image installer

release:
	./scripts/install image release

qemu:
	./scripts/install image qemu

clean:
	rm -rf $(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps
