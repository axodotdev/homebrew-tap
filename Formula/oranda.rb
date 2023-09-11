class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.0/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "71c91ff19409bba503069dba194e606030c326943b75502a36f4fd71b732f046"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.0/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "ad4488434b9f6068b325d51aaf9993d50c2840a34b79d4e0c5bd651639a31f68"
  end
  version "0.4.0"
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
