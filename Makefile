SOURCE="https://dl.bintray.com/probono/AppImages/BlueGriffon-2.0b2.glibc-x86_64.AppImage"
OUTPUT="BlueGriffon.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)
	rm -rf ./AppDir
	xorriso -indev $(OUTPUT) -osirrox on -extract / ./AppDir
	rm -f $(OUTPUT)
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)
	rm -rf ./AppDir

