BUILD_DIRS="build.*"

all: system

system:
	./scripts/image

release:
	./scripts/image release

clean:
	rm -rf $(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps
