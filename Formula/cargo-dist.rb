class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.2/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "6340eaed748aa85eaa4d3485b8afdfe1574e0e1d2ffadcebecdfb56a65410313"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.2/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "5f6a6f0e8534fcf3dbc98d0db43d6ef2299f129c8c6e5c327021462ede87c6ce"
  end
  version "0.3.0-prerelease.2"
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
