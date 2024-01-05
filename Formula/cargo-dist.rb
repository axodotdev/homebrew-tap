class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.7.0"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "0ca3af5f22692ee61e6517debfeebf210256b812fc4a106eee8ec11ee7fb0372"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "5c5a72b98a9160967aaf1107aece87ab9124ceca1e3815295a2201844763c764"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a57bde006cd799ae6d55dd09dc494f4013d807d9442a7ba01ff547b01b1e3ef"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68e66a776ee260afc82c2ce458a376ea27bec0f9a15f60f7a3cf9a3bf45986d8"
    end
  end
  license "MIT OR Apache-2.0"

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
