sudo rm -f /bin/uname
echo '#!/bin/busybox ash
case "$1" in
  -r)
    echo "6.12.11-tinycore64"
    ;;
  -m)
    echo "x86_64"
    ;;
  -s)
  echo "Linux"
  ;;
  -v)
  echo "#1 SMP Sun Jan 26 16:50:13 UTC 2025"
  ;;
  *)
    echo "6.12.11-tinycore64"
    ;;
esac' | sudo tee /bin/uname > /dev/null
sudo chmod +x /bin/uname
tce-load -lwi compiletc libffi-dev python3.9 squashfs-tools jq upx submitqc curl sstrip

workdir=$(mktemp -d)
cd $workdir
version=1.25.0

wget --no-check-certificate -O- https://github.com/micropython/micropython/releases/download/v$version/micropython-$version.tar.xz | tar -xJ
cd micropython-$version/ports/unix/
#for some reason, the first make with cflags causes error. you need to compile with just "make" then pass the flags
make
make clean
CFLAGS="-ftree-vectorize -fipa-pta -funroll-loops -floop-nest-optimize -Ofast -march=alderlake -mtune=alderlake -flto" CXXFLAGS="-fmerge-all-constants -ftree-vectorize -fipa-pta -funroll-loops -floop-nest-optimize -Ofast -march=alderlake -mtune=alderlake -flto" make -j4
bindir=$(mktemp -d)
mkdir -p $bindir/usr/local/bin/
mv build-standard/micropython $bindir/usr/local/bin/
sstrip -z $bindir/usr/local/bin/micropython
mksquashfs $bindir micropython.tcz
sudo submitqc --nonet --blocksize=65536 micropython.tcz
mv -f micropython.tcz /output
