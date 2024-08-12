class NumbersGuy < Formula
  desc "📈 a little CLI for fetching release and release asset data from GitHub"
  homepage "https://github.com/axodotdev/numbers-guy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/numbers-guy/releases/download/v0.1.0/numbers-guy-aarch64-apple-darwin.tar.gz"
      sha256 "1be58b54cb0c372acd373c2b93478b7d2c49dc5de1ee267f5c234b593f844421"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/numbers-guy/releases/download/v0.1.0/numbers-guy-x86_64-apple-darwin.tar.gz"
      sha256 "45361e5f619965b94ebf08a76a786d607a994f9191104d1c432bb354e3e94bb7"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/numbers-guy/releases/download/v0.1.0/numbers-guy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b5cc585eab8439eafd9a590679d523144d761da73f9b1392d1f58ea7b1216a8b"
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
