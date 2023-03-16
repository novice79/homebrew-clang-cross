class Aarch64AlpineLinuxMusl < Formula
    desc "aarch64 Linux MUSL Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/aarch64-alpine-linux-musl.tar.gz"
    sha256 "ea52a459e40aa6ce2a3f3a74b1e812c143aef9a5f7a53c8ec65328fc5d1aa851"
    version "1.0.1"
  
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
        system "./link-bin.sh", llvm_prefix, coreutils_prefix
        bin.install Dir["bin/*"]
        # Dir.glob("./bin/*") {|file| bin.install file}
      end
    end
  end