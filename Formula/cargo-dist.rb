class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.2/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "d45d0ad90036905f44e394ecbc33f47ee792baf7574733f54250ab193d571358"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.2/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "bb23b6320d42123147c94a65c581336729da7ef64b119f0cbeef691b327e8944"
  end
  version "0.4.2"
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
