class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.6.0/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "6221def1857e31731c3f7e2df917f01aae256961d1096299b97c6ed7f6a7adb5"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.6.0/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "cd6db39953659df92ae2ed83be7d7c9b8924444cb50b0a5665239f6cf91ba8d0"
  end
  version "0.6.0"
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
