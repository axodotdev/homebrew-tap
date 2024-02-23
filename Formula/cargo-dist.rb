class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.11.1"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_liT4KbTVNjUsFWPi-fDQF/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "e8813ce050a07c9ddb19eeefa9e26b8bfb56fe62f66c32de743a00c9bba77326"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_liT4KbTVNjUsFWPi-fDQF/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "5d124f4b8b2dcdba1844bec0c2f2ab74601ce26d85ed47590c31993d26163c67"
    end
  end
  on_linux do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_liT4KbTVNjUsFWPi-fDQF/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e6d39732af06c4fcb3d9bee88f651e2ce9085263533d5b34d639b61c7d73bfac"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_liT4KbTVNjUsFWPi-fDQF/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9446ddb4852a2b2c46354278dddff16c11306e628cc32351dfc311bb4be85bc6"
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
