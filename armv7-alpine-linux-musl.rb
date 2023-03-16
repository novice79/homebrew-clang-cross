class Armv7AlpineLinuxMusl < Formula
    desc "armv7 Linux MUSL Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/armv7-alpine-linux-musl.tar.gz"
    sha256 "8d4b348a706197caec38adb0164aacc70b868b38f04d8a241d0bf351f1d2a1e2"
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