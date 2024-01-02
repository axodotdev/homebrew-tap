class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.6.3"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.3/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "42094e3b0b952dd569a26ae9c454d290afae00677de01c9197839e36800efb82"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.3/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "8a9e6c8afa9a6b79686aef7f0767303696e41a7cf774131d339c18be1f53a6a8"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.3/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef084b54ec90a700c9971fba7262acf7494787d9955648094c7a45faea5377eb"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.3/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4211f2a9665a0658ef2da0eafbac3338e1c8700912e722e32e033fb0816a24c4"
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
