class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.6.1"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.1/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "64a9e2c4485810dcb9743215205ec10603a1906a975834fdee253f769b8ad15f"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.1/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "90055a8af72fcdfec74e55db5f8c0b80b0ae5b67c858f29d1e6266d3ea481338"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.1/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b97115f2d25805e9c821c9af819a72ea7bb8f9c6bce6873f3b9c317f4c864757"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.1/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ae4f407321eae52d465ccfab7020eab51a117bcb14f0773c00e195351a736291"
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
