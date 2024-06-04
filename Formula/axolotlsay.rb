class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/axodotdev/axolotlsay"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.4/axolotlsay-aarch64-apple-darwin.tar.gz"
      sha256 "6037f0885d63fbaaa9e0c96ccbf60255a14b0b20835fd7962dbf2e1605838fad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.4/axolotlsay-x86_64-apple-darwin.tar.gz"
      sha256 "a6dc581e83e828fa572b8d99613159b1ecdef47e493b50359230b94d2eb3339b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.4/axolotlsay-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff5f015507da27dd521cc3ac7b61c712a70753ea73ed7efc8c7524ab85e3d891"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.4/axolotlsay-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99e8a2d175ca578bb4f6436647a711a63779b83ac655803374266528fcb46e64"
    end
  end
  license "MIT OR Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "aarch64-unknown-linux-musl-dynamic": {}, "aarch64-unknown-linux-musl-static": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "axolotlsay"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "axolotlsay"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "axolotlsay"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "axolotlsay"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
