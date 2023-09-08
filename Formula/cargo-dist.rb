class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.4/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "97acdb68d24cdceef6325fe988e6689c6632bb66ab9bc054f2c6bb7b6607181f"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.4/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "1cae842503ed85dc46933e1560f33fdaa307784d9a895a298bebdab0f6e9cff0"
  end
  version "0.3.0-prerelease.4"
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
