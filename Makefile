BUILD_DIRS="build.*"

all: image

image:
	./scripts/install image full

clean:
	rm -rf $(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps