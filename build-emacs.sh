#!/bin/bash

set -v

repo_branch=$1
native_comp=$2

pacman --noconfirm -S --needed \
    base-devel \
    mingw-w64-ucrt-x86_64-toolchain \
    mingw-w64-ucrt-x86_64-xpm-nox \
    mingw-w64-ucrt-x86_64-gmp \
    mingw-w64-ucrt-x86_64-gnutls \
    mingw-w64-ucrt-x86_64-libtiff \
    mingw-w64-ucrt-x86_64-giflib \
    mingw-w64-ucrt-x86_64-libpng \
    mingw-w64-ucrt-x86_64-libjpeg-turbo \
    mingw-w64-ucrt-x86_64-librsvg \
    mingw-w64-ucrt-x86_64-libwebp \
    mingw-w64-ucrt-x86_64-lcms2 \
    mingw-w64-ucrt-x86_64-libxml2 \
    mingw-w64-ucrt-x86_64-zlib \
    mingw-w64-ucrt-x86_64-harfbuzz \
    mingw-w64-ucrt-x86_64-libgccjit \
    mingw-w64-ucrt-x86_64-sqlite3 \
    mingw-w64-ucrt-x86_64-libtree-sitter

pacman --noconfirm -S git autotools
git config --global core.autocrlf false

mkdir /c/emacs
cd /c/emacs
git clone --depth=1 --branch ${repo_branch} https://github.com/emacsmirror/emacs.git emacs-repo

install_dir=/c/programs/emacs
cd /c/emacs/emacs-repo
./autogen.sh
./configure --prefix=${install_dir} ${native_comp} --with-gnutls --with-xpm --with-tree-sitter --without-dbus --without-pop
NPROC=$(nproc)
make -j${NPROC}
make install

cp -v /ucrt64/bin/libbrotlicommon.dll ${install_dir}/bin
cp -v /ucrt64/bin/libbrotlidec.dll ${install_dir}/bin
cp -v /ucrt64/bin/libbrotlienc.dll ${install_dir}/bin
cp -v /ucrt64/bin/libbz*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libcairo-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libdatrie-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libdeflate.dll ${install_dir}/bin
cp -v /ucrt64/bin/libexpat-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libffi-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libfontconfig-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libfreetype-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libfribidi-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgcc_s_seh-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgdk_pixbuf-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgif-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgio-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libglib-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgmodule-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgmp-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgnutls-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgobject-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libgraphite*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libharfbuzz-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libhogweed-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libiconv-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libidn*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libintl-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libisl-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libjbig-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libjpeg-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/liblcms*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libLerc.dll ${install_dir}/bin
cp -v /ucrt64/bin/liblzma-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libmpc-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libmpfr-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libnettle-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libp11-kit-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpango-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpangocairo-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpangoft*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpangowin32-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpcre*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpixman-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libpng*.dll ${install_dir}/bin
cp -v /ucrt64/bin/librsvg*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libsharpyuv-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libsqlite*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libstdc++-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libtasn1-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libthai-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libtiff-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libtree-sitter-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libunistring-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libwebp-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libwebpdemux-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libwinpthread-*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libxml*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libXpm*.dll ${install_dir}/bin
cp -v /ucrt64/bin/libzstd.dll ${install_dir}/bin
cp -v /ucrt64/bin/wasmtime.dll ${install_dir}/bin
cp -v /ucrt64/bin/zlib*.dll ${install_dir}/bin

if [[ "${native_comp}" != "--without-native-compilation" ]]; then
    cp -v /ucrt64/bin/libgccjit*.dll ${install_dir}/bin
    mkdir -p ${install_dir}/lib/gcc
    cp -v /ucrt64/lib/{crtbegin,crtend,dllcrt2}.o ${install_dir}/lib/gcc
    cp -v /ucrt64/lib/lib{advapi32,gcc_s,kernel32,mingw32,mingwex,moldname,msvcrt,pthread,shell32,user32}.a ${install_dir}/lib/gcc
    cp -v /ucrt64/lib/gcc/x86_64-w64-mingw32/[0-9][0-9].[0-9].[0-9]/libgcc.a ${install_dir}/lib/gcc
    cp -v /ucrt64/bin/{ld,as}.exe ${install_dir}/lib/gcc
    cp -v /ucrt64/bin/libzstd.dll ${install_dir}/lib/gcc
    cp -v /ucrt64/bin/zlib*.dll ${install_dir}/lib/gcc
fi

cd /c/programs/
zip -9rq emacs.zip emacs
