class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.12.1"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_9qUCPlnGAYYo8hjqhNQad/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "360a81b87c8c6062ceb3bf8aa50be3001d12c4c0722ffe120d0077592d7a281c"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_9qUCPlnGAYYo8hjqhNQad/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "3c0712931bba017a6fcc0d84861e686a896b82305c81328e18807e4714540d11"
    end
  end
  on_linux do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_9qUCPlnGAYYo8hjqhNQad/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f32f8b5a93efd43a2f838d35152deffda8adc06bfa86e87d739c60a494a45fab"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_9qUCPlnGAYYo8hjqhNQad/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ef3b6026263512998a818c1577ce8a2ab609bca2b0cd70b51c46a4aece9bfb9"
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
