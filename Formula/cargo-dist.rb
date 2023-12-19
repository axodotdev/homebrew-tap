class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.6.0"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "d306f432c9e33eb7cffcc290c869ae1bd00aae529fd5d2739659f8129abf2415"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "823e3e545ed681eb72aaff0ee64ccc75fb11389158ebb633de65f2d0aaade828"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "62b704b225c5ee35ac0b1cff3b25fb1c2d7b0961f4eea4fab02e1ee2c3f05708"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8f25be146ab66f63b98f74177b004957694212a253f2326cf4f7358d51ceb4ae"
    end
  end
  license "MIT OR Apache-2.0"
  
  depends_on "xz"

  def install
    bin.install "cargo-dist"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
