class Armv6AlpineLinuxMusl < Formula
    desc "armv6 Linux MUSL Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/armv6-alpine-linux-musl.tar.gz"
    sha256 "fbbe8f484657ce6c86ed1ff1a2af3bb7e13133bf270546393ff5fd44da3bf031"
    version "1.0.0"
  
    depends_on "bash"
    depends_on "coreutils"
    depends_on "llvm"
    # ohai for general info
    # opoo for warning messages
    # odie for error messages and immediately exiting

    def install
      prefix.install Dir["./*"]
      llvm_prefix = Formula["llvm"].prefix
      coreutils_prefix = Formula["coreutils"].prefix
      # ohai "llvm_prefix=#{llvm_prefix}"
      cd prefix do
        # self construct bin, so not need bin.install ...
        system "./link-bin.sh", llvm_prefix, coreutils_prefix
      end
    end
  end