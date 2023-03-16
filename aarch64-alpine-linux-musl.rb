class Aarch64AlpineLinuxMusl < Formula
    desc "aarch64 Linux MUSL Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/aarch64-alpine-linux-musl.tar.gz"
    sha256 "8b999487ca2f8e8b80b42ad4e2c356ab9dc80387e0dd3824526274b10346c065"
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
      ohai "llvm_prefix=#{llvm_prefix}"
      cd prefix do
        system "./link-bin.sh", llvm_prefix
      end
      
      Dir.glob(prefix/"bin/*") {|file| bin.install_symlink file}
    end
  end