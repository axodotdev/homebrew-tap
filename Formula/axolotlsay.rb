class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.1/axolotlsay-aarch64-apple-darwin.tar.gz"
    sha256 "eea2af2cdcc6ad75a43d2f10748a917dc943423b056dd01a6e227e3b68212fc6"
  else
    url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.1/axolotlsay-x86_64-apple-darwin.tar.gz"
    sha256 "76a25a259f1069e23c8ad72759256e99d3f84a031ba38f05c35385317ed04aa6"
  end
  version "0.2.1"
  license "MIT OR Apache-2.0"

  def install
    bin.install "axolotlsay"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
