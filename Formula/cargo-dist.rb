class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.2.0-prerelease.6/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "e489837a50be9269bc324706c04bf4eef6067655701760d642bdd1989ad17ae3"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.2.0-prerelease.6/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "221592b113c2f02bad116919e9c8de956895b9b8de5b1c424ed0e039dd487fe5"
  end
  version "0.2.0-prerelease.6"
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
