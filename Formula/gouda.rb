class Gouda < Formula
  desc "The server cli for grit"
  homepage "https://docs.grit.io"
  version "0.1.0-alpha.1715705948"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715705948/gouda-aarch64-apple-darwin.tar.gz"
      sha256 "0aeda87199b426cba98a286eee1500f59e0190446993d923831c988598a97b76"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715705948/gouda-x86_64-apple-darwin.tar.gz"
      sha256 "8a9c5ac07baffd41d59f614a17f445da05ce70bd5d3446b5873328c1c90012a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715705948/gouda-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ebb0d4bd9638b051e564feec4e16018b3ca80ff54c6b964aa62afc0ace0da3d1"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "gouda"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gouda"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gouda"
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