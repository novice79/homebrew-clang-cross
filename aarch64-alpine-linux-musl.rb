class Aarch64AlpineLinuxMusl < Formula
    desc "aarch64 Linux MUSL Toolchain"
    homepage "https://github.com/novice79/homebrew-clang-cross"
    url "https://github.com/novice79/homebrew-clang-cross/releases/download/v1.0.0/aarch64-alpine-linux-musl.tar.gz"
    sha256 "52cf17903c03f7198650833251e02da5218e2b7d01b6ae74bf4c81fcd8bcd0fe"
    version "1.0.0"
  
    depends_on "bash"
    depends_on "coreutils"
    depends_on "llvm"


    def install
      (prefix).install Dir["./*"]
      Dir.chdir(prefix)
      system "./link-bin.sh"
      Dir.glob(prefix/"bin/*") {|file| bin.install_symlink file}
    end
  end