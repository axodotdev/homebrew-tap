class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.0-prerelease.2/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "515d5818a1ed7a096affcf2ba79f6741cdba48e3bd63a6ca31bb488646c442d8"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.0-prerelease.2/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "fb0f34b2239b3e820930605f106fd660ef3c81f6ab5b8bf03cfa195aa91fdc27"
  end
  version "0.4.0-prerelease.2"
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
