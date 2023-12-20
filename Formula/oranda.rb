class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.6.1/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "0e8169002de70a2e19cf28f6aa5c5000e2d17ebc523120dea57fab732881959f"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.6.1/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "48716a862143dde91bfd4e1577dc72e401990313c247c732908b9f7687711332"
  end
  version "0.6.1"
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
