class Grit < Formula
  desc "GritQL is a query language for searching, linting, and modifying code"
  homepage "https://docs.grit.io/"
  version "0.1.0-alpha.1715705948"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715705948/marzano-aarch64-apple-darwin.tar.gz"
      sha256 "e078361a2c04b110b1de936c6d7b672c7acd258d2ce14f15097ba07b94526786"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715705948/marzano-x86_64-apple-darwin.tar.gz"
      sha256 "fb203114b4687b0a41a8948cb94e516f50fa25bcb4258b3409a91a6d423590e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715705948/marzano-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "efec43f274846ddaea260c889cd8898f74c6ea46b5696d28d3baf72c940e8276"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {"marzano": ["grit"]}, "x86_64-apple-darwin": {"marzano": ["grit"]}, "x86_64-pc-windows-gnu": {"marzano.exe": ["grit.exe"]}, "x86_64-unknown-linux-gnu": {"marzano": ["grit"]}}

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
      bin.install "marzano"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "marzano"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "marzano"
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
