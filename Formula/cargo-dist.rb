class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.8.0"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "234abe2bc5535ab6f13900814f0fa8fc2239b140fb4bbe9afe96399a3763588c"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "3a131a65bef832a825ae2fd9f1a88b0637bf0122bae3cc79f01cb348365a1d44"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6efb39ebedb2dfb22023e5b31989ea4f277e82e6d0718ca97f2dee96c3ba6e52"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea17dfbd0ca20d03c219eb362651f9364cd313488fc87c7afadb9409408da054"
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
