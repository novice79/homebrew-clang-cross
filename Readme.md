# Clang cross compiler

Inspired by [Clang and LLVM made cross compiling easy](https://mcilloni.ovh/2021/02/09/cxx-cross-clang/)

Basiclly you only need [sysroot + llvm/clang + some bash scripts], can do lots of cross compiling.

So I extract linux(arm & x86) sysroot from docker container, and download windows sysroot form [winlibs](https://winlibs.com/).

total:

- armv6-alpine-linux-musl
- armv7-alpine-linux-musl
- aarch64-alpine-linux-musl
- x86_64-alpine-linux-musl
- i686-w64-windows-gnu
- x86_64-w64-windows-gnu

for now 

# Install using Homebrew(on macos or linux)

```bash
brew tap novice79/clang-cross
brew install aarch64-alpine-linux-musl
brew install armv7-alpine-linux-musl
...
etc.
```


# Usage

    armv7-alpine-linux-musl-cc main.c 
    armv7-alpine-linux-musl-c++ main.cpp
    ...

examples for cmake/meson/autotools build to be continued