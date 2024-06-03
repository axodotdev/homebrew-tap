class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/axodotdev/axolotlsay"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.3/axolotlsay-aarch64-apple-darwin.tar.gz"
      sha256 "cf3173d8ce125a85b2a08d8e261e85ae18eb95b900fa8d2c46e6182c5e3ce46f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.3/axolotlsay-x86_64-apple-darwin.tar.gz"
      sha256 "331e1666b4f49471ec63f4914038d876b72267b9ab845ebfc90eb0e73c116bc0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.3/axolotlsay-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "13846664f6d6f3c8f43c51efec924cd9b0bcc0b85e961a8779614306772ca358"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.2.3/axolotlsay-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "94fc3722636695a8390b79de2664b79a827429bc3f92ac173b96078ab2bba848"
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
