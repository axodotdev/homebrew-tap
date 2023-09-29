class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.5.0-prerelease.1/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "03166d6cb293622b07a1c2b29f57314c0b5d8234ef753a8482f85d9e5ac29e12"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.5.0-prerelease.1/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "26fdb4d204f2c7c0f52815b48b755527a43ccc3bb971a727fa769d8b09908dcb"
  end
  version "0.5.0-prerelease.1"
  license "MIT OR Apache-2.0"

  def install
    bin.install "oranda"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
