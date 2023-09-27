class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.1/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "0af34c0ef7d56531ae1b230deee925aa4936d1369fc75c55f4c8581a05cd8fd0"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.1/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "5c930202d44701ea7e6583e6059a11192b49fcd5cb442e7ebba5cfab9573c219"
  end
  version "0.4.1"
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
