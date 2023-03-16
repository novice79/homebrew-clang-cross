#!/usr/bin/env bash
# set -e
# set -x

# prerequisite:
# brew tap novice79/clang-cross
# brew install i686-w64-windows-gnu x86_64-w64-windows-gnu

# curl -sL https://zlib.net/zlib-1.2.13.tar.gz | tar zxvf - -C $HOME/cpp_libs/
# curl -sL https://www.openssl.org/source/openssl-1.1.1t.tar.gz | tar zxvf - -C $HOME/cpp_libs/
# curl -sL https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.gz \
# | tar zxvf - -C $HOME/cpp_libs/
work_dir="$(dirname "$(realpath "$BASH_SOURCE")")"
target=( 
   i686-w64-windows-gnu:mingw:32
   x86_64-w64-windows-gnu:mingw64:64
)
ZLIB_ROOT="$HOME/cpp_libs/zlib-1.2.13"
OPENSSL_ROOT="$HOME/cpp_libs/openssl-1.1.1t"
BOOST_ROOT=$HOME/cpp_libs/boost_1_81_0

for i in "${target[@]}";do
    IFS=':' read -ra t <<< "$i"
    # source "$(brew --prefix ${t[0]})/env.sh"
    mkdir -p "$work_dir/_build" && cd "$work_dir/_build"
    PREFIX="$work_dir/dist/${t[1]}"
    # build zlib
    CHOST=${t[0]} "$ZLIB_ROOT/configure" --static --prefix=$PREFIX
    make clean install

    # build openssl
    [[ -f Makefile ]] && make clean
    $OPENSSL_ROOT/Configure \
    ${t[1]} no-tests no-shared no-dso no-engine \
    no-autoload-config no-cms no-deprecated \
    --cross-compile-prefix=${t[0]}- --prefix=$PREFIX
    # perl _build/configdata.pm --dump
    make -j8
    make install_sw

    # build boost
    echo "using gcc :  : ${t[0]}-g++ ;" > /tmp/wb.jam
    cd $BOOST_ROOT
    [[ ! -f "./b2" ]] && ./bootstrap.sh
    ./b2 -a --user-config=/tmp/wb.jam --prefix="$PREFIX" \
    cxxstd=20 link=static threading=multi runtime-link=shared \
    target-os=windows address-model=${t[2]} variant=release install
done

