all: dist deb

deb:
	-dpkg-buildpackage -r"sudo su root"
	mkdir -p dist
	mv -f $(shell /bin/ls -1 -rt ../emma_*deb | tail -1) ./dist
	scp $(shell /bin/ls -1 -rt dist/emma_*deb | tail -1) root@maggie:/var/www/debian/dists/unstable/main/binary-i386
	ssh root@maggie /root/bin/rescan_packages
	
dist:
	python2.4 setup.py sdist

clean:
	-sudo rm -rf build build-stamp debian/emma
	sudo find ./emmalib -iname "*.py[co]" --exec rm "{}" ";"
	