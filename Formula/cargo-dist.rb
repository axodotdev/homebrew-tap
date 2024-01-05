class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.7.1"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.1/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "ead92f259275269238e2693f0e29ed513bb2ef1beaacf369c31085f0e6be12e1"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.1/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "ee5fce3a50c645483998dea457294f892ed884053319927f67efb1c0c1435ffb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.1/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cdea8c19cf0186a2f9583a5608e4c9069a57f3710bed0f69fb11658e7a932dc5"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.7.1/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "16b0409c126572ec4ccba84cc5f46629887720cd7d78d3b99a2742ac5a214252"
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
