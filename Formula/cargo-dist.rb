class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.10.0"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_jgJmW7Pwj7KxnHR43Ec-X/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "d7839751b1c6e14042134384dcbd1494e1903b5e6c2b53210a857e80c6e6d8f1"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_jgJmW7Pwj7KxnHR43Ec-X/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "e6a5c295e0f1befc2bc00d480fa7af903b11a743e7c285cc03da849a8fe34ff9"
    end
  end
  on_linux do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_jgJmW7Pwj7KxnHR43Ec-X/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "96522c31b891121c852b52a342fd91f49b3e4e75fcf0f0795e44f667360c9876"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_jgJmW7Pwj7KxnHR43Ec-X/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4eefdf0704e4dcbc4fe3db55f2a4e92045c4f9e1a9ee488c95a09f2331af0a3a"
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
