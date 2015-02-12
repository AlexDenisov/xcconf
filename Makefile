INSTALL_DIR?=/usr/local/bin

install: build
	cp ./build/Release/xcconf ${INSTALL_DIR}/xcconf

.PHONY: build
build:
	xcodebuild -target xcconf -configuration Release 2>&1 1>/dev/null

clean:
	rm -rf build

