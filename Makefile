install: build
	cp ./build/Release/xcconf /usr/local/bin/xcconf

.PHONY: build
build:
	xcodebuild -target xcconf -configuration Release

