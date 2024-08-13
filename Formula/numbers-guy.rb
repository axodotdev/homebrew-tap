class NumbersGuy < Formula
  desc "📈 a little CLI for fetching release and release asset data from GitHub"
  homepage "https://github.com/axodotdev/numbers-guy"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/numbers-guy/releases/download/v0.1.1/numbers-guy-aarch64-apple-darwin.tar.gz"
      sha256 "4e99b00464290565d484574059042ca9769bf7a6b7800e36da39a5a78b744a7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/numbers-guy/releases/download/v0.1.1/numbers-guy-x86_64-apple-darwin.tar.gz"
      sha256 "caa83b891ca94ef97cdf24f08050e091d2a00151a9fe8c62302ca06e66a39e65"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/numbers-guy/releases/download/v0.1.1/numbers-guy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f50534acea2b9a9192578fc651daf60ec73b52a15f9eb68b0604c84ff94e9937"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "numbers-guy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "numbers-guy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "numbers-guy"
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
