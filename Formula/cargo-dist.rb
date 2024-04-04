class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.12.2"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_s-6JvvW3s0ZRQmipdqLNV/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "25a6192959bcc318adb5ef801cca0fdcf6c574860e9b8e83a54a8f757a4ea254"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_s-6JvvW3s0ZRQmipdqLNV/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "bcda24a71b60e543738e2169b036d296e8f0d614214c041def5423a82c99c55f"
    end
  end
  on_linux do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_s-6JvvW3s0ZRQmipdqLNV/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9df327e7c542df6f09573b8f1b2bd4fbbe0dd8cf8acab97fe2c685979af92717"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_s-6JvvW3s0ZRQmipdqLNV/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2716df99a5bb75bb6037f797b03b2501886319791c93612be8fc73783d830ca9"
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
