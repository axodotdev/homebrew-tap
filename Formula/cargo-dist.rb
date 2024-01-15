class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.7.2"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.2/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "498da9b7c9d09fe876d7782e30a6c6e875d78fdaf830cded44c025dbe65dfd1b"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.2/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "f6152b9d519429da75154585acb159714c8eb138c852764f7f4d4cf74051b263"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.2/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bda5ce690ace7a507ef4e7971eafce43ecd6502effb974ed7522bfecdc37abdd"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.2/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1da4a41b0a73335ffda19610aa3b6f2be782e92ed030e6ecd372b7a47b1aee29"
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
