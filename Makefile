# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean
	mkdir --parents $(PWD)/build/squashfs-root
	mkdir --parents $(PWD)/build/squashfs-root/lib
	mkdir --parents $(PWD)/build/squashfs-root/bluegriffon
	mkdir --parents $(PWD)/build/squashfs-root/share

	wget --output-document=$(PWD)/build/build.deb http://bluegriffon.org/freshmeat/3.1/bluegriffon-3.1.Ubuntu18.04-x86_64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/cairo-1.15.12-4.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libpng-1.5.13-8.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	mkdir --parents $(PWD)/build/squashfs-root/usr/lib
	mkdir --parents $(PWD)/build/squashfs-root/usr/share

	cp --force --recursive $(PWD)/build/usr/lib64/* $(PWD)/build/squashfs-root/lib
	cp --force --recursive $(PWD)/build/opt/bluegriffon/* $(PWD)/build/squashfs-root/bluegriffon
	cp --force --recursive $(PWD)/build/usr/share/* $(PWD)/build/squashfs-root/share
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/squashfs-root


	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/squashfs-root $(PWD)/BlueGriffon.AppImage
	chmod +x $(PWD)/BlueGriffon.AppImage

clean:
	rm -rf $(PWD)/build



