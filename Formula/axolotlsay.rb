class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.0/axolotlsay-aarch64-apple-darwin.tar.gz"
    sha256 "90520c70f16b5298b81d58ec8dd77252caff4d196378a36637e9a8f8780ab3f7"
  else
    url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.0/axolotlsay-x86_64-apple-darwin.tar.gz"
    sha256 "39d4d6cb3aa5f40b8664781e7f4d149e46b8fa4ff2c9909a97cdcdcf2490b994"
  end
  version "0.2.0"
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
