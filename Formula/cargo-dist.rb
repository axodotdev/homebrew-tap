class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.3/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "ac1615a4b42de086b8f69eb48b0a92e3973181a6b1fc0e7b201994fa5f68318e"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.3/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "eb07c573cbd6f6b7682f055a0c21e1bee45b20c687cb32f15976ece4eb706655"
  end
  version "0.3.0-prerelease.3"
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
