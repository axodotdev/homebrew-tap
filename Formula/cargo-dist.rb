class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.8.1"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.1/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "b27ed3c16a75567d7619c6bc5e2fde18b18687d004fd37885742520dce93b6d2"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.1/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "223b583e52b90ffe317ca170da1f880ac6afc234fb47fd1863d61ead2897b855"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.1/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e37ecd95c46d719e256745000ab5f2ae6f49a2c03f3f92144a3eb801c20654c"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.1/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "261b2fcd23499f39ab19a2bc0ab3a8dd475a743e35625c2985b908ddf8b6f13e"
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
