PREFIX?=/usr/local
BIN_DIR=${PREFIX}/bin

all: build

install:
	mkdir -p ${BIN_DIR}
	cp ./build/Release/xcconf ${BIN_DIR}/xcconf

.PHONY: build
build:
	xcodebuild -target xcconf -configuration Release

clean:
	rm -rf build

