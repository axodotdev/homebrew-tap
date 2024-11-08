class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/axodotdev/axolotlsay"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.1/axolotlsay-aarch64-apple-darwin.tar.gz"
      sha256 "ed41bf504907b28015e8c17cc740e79dac4358a2f928c5c62851811507ac5535"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.1/axolotlsay-x86_64-apple-darwin.tar.gz"
      sha256 "6a02c39bb4129055459533984c9b8ed6c7258a6dd282e34a0830d5cbb71367f5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.1/axolotlsay-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9a564487a8aeee4848e693d58012864ac98e67e6406934727c2a14a5667ff72b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.1/axolotlsay-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "735b3102bdbdbcf66eda992c6a92e477bf73f27776270f8f55f5c49c41247a89"
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
