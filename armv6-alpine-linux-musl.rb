class Armv6AlpineLinuxMusl < Formula
    desc "armv6 Linux MUSL Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/armv6-alpine-linux-musl.tar.gz"
    sha256 "32e0ea7a71864fb10069b3e2d3a1f5e234f2b9ab2a3fa452a1a6cfe134153d34"
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