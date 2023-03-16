class I686W64WindowsGnu < Formula
    desc "Windows x86_64 mingw Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/x86_64-w64-windows-gnu.tar.gz"
    sha256 "e3aca556266088b04a782013ad7dd1158887ad2a1d5e70946a31cc28c6dddf86"
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