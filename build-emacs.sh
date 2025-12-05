#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

repo_branch=$1
native_comp=$2
msys=$3
menv=$4

pacman --noconfirm -S --needed \
    base-devel \
    mingw-w64-${menv}-toolchain \
    mingw-w64-${menv}-xpm-nox \
    mingw-w64-${menv}-gmp \
    mingw-w64-${menv}-gnutls \
    mingw-w64-${menv}-libtiff \
    mingw-w64-${menv}-giflib \
    mingw-w64-${menv}-libpng \
    mingw-w64-${menv}-libjpeg-turbo \
    mingw-w64-${menv}-librsvg \
    mingw-w64-${menv}-libwebp \
    mingw-w64-${menv}-lcms2 \
    mingw-w64-${menv}-libxml2 \
    mingw-w64-${menv}-zlib \
    mingw-w64-${menv}-harfbuzz \
    mingw-w64-${menv}-libgccjit \
    mingw-w64-${menv}-sqlite3 \
    mingw-w64-${menv}-libtree-sitter

pacman --noconfirm -S git autotools
git config --global core.autocrlf false

mkdir /c/emacs
cd /c/emacs
git clone --depth=1 --branch ${repo_branch} https://git.savannah.gnu.org/git/emacs.git emacs-repo

install_dir=/c/programs/emacs
cd /c/emacs/emacs-repo
./autogen.sh
./configure --prefix=${install_dir} ${native_comp} --with-gnutls --with-xpm --with-tree-sitter --without-dbus --without-pop
NPROC=$(nproc)
make -j${NPROC}
make install

cp -v /${msys}/bin/libbrotlicommon.dll ${install_dir}/bin
cp -v /${msys}/bin/libbrotlidec.dll ${install_dir}/bin
cp -v /${msys}/bin/libbrotlienc.dll ${install_dir}/bin
cp -v /${msys}/bin/libbz*.dll ${install_dir}/bin
cp -v /${msys}/bin/libcairo-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libdatrie-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libdeflate.dll ${install_dir}/bin
cp -v /${msys}/bin/libexpat-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libffi-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libfontconfig-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libfreetype-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libfribidi-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgcc_s_seh-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgdk_pixbuf-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgif-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgio-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libglib-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgmodule-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgmp-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgnutls-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgobject-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libgraphite*.dll ${install_dir}/bin
cp -v /${msys}/bin/libharfbuzz-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libhogweed-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libiconv-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libidn*.dll ${install_dir}/bin
cp -v /${msys}/bin/libintl-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libisl-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libjbig-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libjpeg-*.dll ${install_dir}/bin
cp -v /${msys}/bin/liblcms*.dll ${install_dir}/bin
cp -v /${msys}/bin/libLerc.dll ${install_dir}/bin
cp -v /${msys}/bin/liblzma-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libmpc-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libmpfr-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libnettle-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libp11-kit-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpango-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpangocairo-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpangoft*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpangowin32-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpcre*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpixman-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libpng*.dll ${install_dir}/bin
cp -v /${msys}/bin/librsvg*.dll ${install_dir}/bin
cp -v /${msys}/bin/libsharpyuv-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libsqlite*.dll ${install_dir}/bin
cp -v /${msys}/bin/libstdc++-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libtasn1-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libthai-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libtiff-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libtree-sitter-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libunistring-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libwebp-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libwebpdemux-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libwinpthread-*.dll ${install_dir}/bin
cp -v /${msys}/bin/libxml*.dll ${install_dir}/bin
cp -v /${msys}/bin/libXpm*.dll ${install_dir}/bin
cp -v /${msys}/bin/libzstd.dll ${install_dir}/bin
cp -v /${msys}/bin/wasmtime.dll ${install_dir}/bin
cp -v /${msys}/bin/zlib*.dll ${install_dir}/bin

if [[ "${native_comp}" != "--without-native-compilation" ]]; then
    cp -v /${msys}/bin/libgccjit*.dll ${install_dir}/bin
    mkdir -p ${install_dir}/lib/gcc
    cp -v /${msys}/lib/{crtbegin,crtend,dllcrt2}.o ${install_dir}/lib/gcc
    cp -v /${msys}/lib/lib{advapi32,gcc_s,kernel32,mingw32,mingwex,moldname,msvcrt,pthread,shell32,user32}.a ${install_dir}/lib/gcc
    cp -v /${msys}/lib/gcc/x86_64-w64-mingw32/[0-9][0-9].*/libgcc.a ${install_dir}/lib/gcc
    cp -v /${msys}/bin/{ld,as}.exe ${install_dir}/lib/gcc
    cp -v /${msys}/bin/libzstd.dll ${install_dir}/lib/gcc
    cp -v /${msys}/bin/zlib*.dll ${install_dir}/lib/gcc
fi

cd /c/programs/
zip -9rq emacs.zip emacs
