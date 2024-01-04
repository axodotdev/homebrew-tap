class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.6.4"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.4/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "1917a7dc289aae45ae8494c76dfbbc8a5f4bd547e4276990875e829bc1c07fe5"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.4/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "16650773b2a6c9b813388dc3ae0ffc97025cd67e1e88e28c3f6ec4b30554e6dc"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.4/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dde7d9e784f084e7acafe8fa495ac27f8dcd259dd300f48d879f52126491d554"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.4/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a1c865b780d34734879046c2904ecccaff4b4c0599e128b69598c764e184398"
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
