class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/axodotdev/axolotlsay"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/0.2.5/axolotlsay-aarch64-apple-darwin.tar.gz"
      sha256 "86a070da4bb34db6fac050d52e288eac7c4bed8c1e6c62c6fd5404d95793dc17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/0.2.5/axolotlsay-x86_64-apple-darwin.tar.gz"
      sha256 "1827385a1cebcfbd79fa3635e6606e1b08acc1cd068a6b79ac4b38102690afcb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/0.2.5/axolotlsay-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc57f39f8302d35d1295b5ddeed8000bd126c068f1c2cf9eff57a8a6e20782da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/0.2.5/axolotlsay-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e48e906c88d817dbec1ed065b7f87daa6135e89084876f673346a94c44828a8f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
    bin.install "axolotlsay" if OS.mac? && Hardware::CPU.arm?
    bin.install "axolotlsay" if OS.mac? && Hardware::CPU.intel?
    bin.install "axolotlsay" if OS.linux? && Hardware::CPU.arm?
    bin.install "axolotlsay" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
