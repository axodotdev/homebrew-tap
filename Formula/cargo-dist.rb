class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.6.0"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "0659c30003825c7dacc1457fe6e7b1f0390649d0d5f782f80e3b4acd320e5e70"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "7b3449e4eaa87c7c04f3e35063b42cd424d0402b1b70c41760565583e572f586"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "157a0fd9bc13b385413e60aab7e96d31ad5d2bc5831006789e465d0c4b49e18d"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b1b650bcb5dbb6fe2d1c5c60471a810efec5b1b2e5489519513d78af5ed00ae0"
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
