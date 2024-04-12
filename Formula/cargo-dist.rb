class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.13.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_WvnO6H3RNdN2DImfrQ9Ld/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "2b9dfcaeb5e8cf8206c5a19e763780a33a8246eabd28f06f550c3fb8d62645a1"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_WvnO6H3RNdN2DImfrQ9Ld/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "765ccacf5525375b273aaf859ca2db7d4774252c954fb53f822395390772cccb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_WvnO6H3RNdN2DImfrQ9Ld/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ac430ec49d7c0f2b6a16b6d5cd9c48ea96690d7f466fc7854f8b41ca4dffba48"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_WvnO6H3RNdN2DImfrQ9Ld/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e41baaed5a1d7c33d7581c5c6ca5b92725928d6919321656b053d794beadbc14"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cargo-dist"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargo-dist"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cargo-dist"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargo-dist"
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
