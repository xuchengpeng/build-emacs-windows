#!/bin/bash

set -v

pacman --noconfirm -S --needed \
    base-devel \
    mingw-w64-x86_64-toolchain \
    mingw-w64-x86_64-xpm-nox \
    mingw-w64-x86_64-gmp \
    mingw-w64-x86_64-gnutls \
    mingw-w64-x86_64-libtiff \
    mingw-w64-x86_64-giflib \
    mingw-w64-x86_64-libpng \
    mingw-w64-x86_64-libjpeg-turbo \
    mingw-w64-x86_64-librsvg \
    mingw-w64-x86_64-libwebp \
    mingw-w64-x86_64-lcms2 \
    mingw-w64-x86_64-libxml2 \
    mingw-w64-x86_64-zlib \
    mingw-w64-x86_64-harfbuzz \
    mingw-w64-x86_64-libgccjit \
    mingw-w64-x86_64-sqlite3 \
    mingw-w64-x86_64-tree-sitter

pacman --noconfirm -S git autotools
git config --global core.autocrlf false

mkdir /c/emacs
cd /c/emacs
git clone --depth=1 https://git.savannah.gnu.org/git/emacs.git emacs-master
cd /c/emacs/emacs-master
EMACS_COMMIT=$(git rev-parse --short HEAD)
EMACS_VER=`date  +'%Y%m%d'`_${EMACS_COMMIT}

./autogen.sh
./configure --prefix=/c/programs/emacs --without-dbus --without-native-compilation
NPROC=$(nproc)
make -j${NPROC}
make install

cp -v /mingw64/bin/libbrotlicommon.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libbrotlidec.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libbz*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libcairo-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libcairo-gobject-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libdatrie-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libdeflate.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libexpat-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libffi-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libfontconfig-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libfreetype-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libfribidi-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgcc_s_seh-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgdk_pixbuf-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgif-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgio-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libglib-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgmodule-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgmp-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgnutls-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgobject-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libgraphite*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libharfbuzz-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libhogweed-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libiconv-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libidn*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libintl-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libjbig-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libjpeg-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/liblcms*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libLerc.dll /c/programs/emacs/bin
cp -v /mingw64/bin/liblzma-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libnettle-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libp11-kit-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpango-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpangocairo-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpangoft*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpangowin32-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpcre*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpixman-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libpng*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/librsvg*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libsqlite*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libstdc++-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libtasn1-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libthai-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libtiff-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libtree-sitter.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libunistring-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libwebp-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libwebpdemux-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libwinpthread-*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libxml*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libXpm*.dll /c/programs/emacs/bin
cp -v /mingw64/bin/libzstd.dll /c/programs/emacs/bin
cp -v /mingw64/bin/zlib*.dll /c/programs/emacs/bin

cd /c/programs/
tar -zcf emacs-${EMACS_VER}.tar.gz emacs
