ifeq ($(DISTRO),)
	_D := *
else
	_D := ${DISTRO}
endif
ifeq ($(PROJECT)$(DEVICE),)
	_P := *
else
        ifeq ($(BOARD),)
                _P := ${DEVICE}
	else ifeq ($(DEVICE),)
		_P := ${PROJECT}
	else
		_P := ${BOARD}
	endif
endif

BUILD_DIRS=build.${_D}-${_P}.*

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

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps

distclean:
	rm -rf ./.ccache ./$(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps
