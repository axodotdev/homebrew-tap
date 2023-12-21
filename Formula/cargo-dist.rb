class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.6.2"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.2/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "63f3d750a1baaa95849c4aa824306b6687f8a5fc45486a0ca1b104a0c4738a87"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.2/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "bddf6d73f36eff1a35dd027ee7af4a73f260c4e38466117f6494712af83ba9c0"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.2/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d66e46a24a06ced24fad09906e8433aa51508b3b14331a56b3879a707a1f1b2b"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.6.2/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e11fdf48177c71dfd35d74626f32075f4983c14bdd402c0a0e6c602c603fb5bb"
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
