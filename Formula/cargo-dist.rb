class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.11.0"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_tb3_Np3lpfoRishxpiLS2/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "6480e35dbcbbbefca5eedd6317e0471b714395de319d028ac6749f1c2d0afdbc"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_tb3_Np3lpfoRishxpiLS2/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "36e4e95e271f022347c7acecd886296acc1601fbf7fa4e47bba5edf14088bffa"
    end
  end
  on_linux do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_tb3_Np3lpfoRishxpiLS2/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "454151bc1f6930e464cec435528afdec2a9f91ebc40051a9fdf31fedb352bcaa"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_tb3_Np3lpfoRishxpiLS2/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2fde7a0e7e5c4ad45b49c974cc8dff40311bada1a9a4e9a7db74692a3e630e1d"
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
