#!/usr/bin/env bash

set -e 
# prerequisite:
# brew tap novice79/clang-cross
# brew install armv6-alpine-linux-musl i686-w64-windows-gnu ...

dir=_build/test

target=( 
    armv6-alpine-linux-musl
    armv7-alpine-linux-musl
    aarch64-alpine-linux-musl
    x86_64-alpine-linux-musl
    i686-w64-windows-gnu
    x86_64-w64-windows-gnu
)
for i in "${target[@]}";do
    brew list $i &>/dev/null || continue
    tcf="$(brew --prefix $i)/toolchain.cmake"
    [ -f "$tcf" ] && echo "use cmake toolchain file: $tcf" || continue
    rm -rf "$dir"
    PREFIX="dist/$i"
    cmake -H"test" -B"$dir" \
    -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE=$tcf \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$PREFIX"

    cmake --build $dir --config Release
    cmake --install $dir

    ls -lh $PREFIX
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}"
    file $PREFIX/main*
    printf "${NC}"
done
