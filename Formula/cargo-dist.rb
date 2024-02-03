class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.9.0"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.9.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "82f99136642ec3fc69c57a37a7b8b378709ad3fa9da7ff741c3529a5c9753b5e"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.9.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "b6d1ccedc652cecb8fcda553a38c7c28fd92eb5d7a581300a9e1ed6b902cb00d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.9.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5fab2fec734f1618d6eb121ff2dbe227f254615c497d98cd140d049bf9cb2cf5"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.9.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f2e5c980a0037ca70ee85c6526948801442a3a820a81813edea46f877c0efcc"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "cargo-dist"
      end
    end
    on_macos do
      on_intel do
        bin.install "cargo-dist"
      end
    end
    on_linux do
      on_arm do
        bin.install "cargo-dist"
      end
    end
    on_linux do
      on_intel do
        bin.install "cargo-dist"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
