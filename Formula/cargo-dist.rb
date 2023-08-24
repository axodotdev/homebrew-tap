class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.2.0-prerelease.5/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "03fb2674a26261d9ca5c22522e77ee6549e4cddee2d3e69457b3b87f89e07bb6"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.2.0-prerelease.5/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "42f29ace13975a85d598302535d1649aebbee2eac14d52d9014f50c304f5838e"
  end
  version "0.2.0-prerelease.5"
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