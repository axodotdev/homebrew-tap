class Grit < Formula
  desc "GritQL is a query language for searching, linting, and modifying code"
  homepage "https://docs.grit.io/"
  version "0.1.0-alpha.1715348647"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715348647/marzano-aarch64-apple-darwin.tar.gz"
      sha256 "9d85e9796ba2b75156948f57e9de1a3293ef4c19336acb72b282d4bf8a6f6dee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715348647/marzano-x86_64-apple-darwin.tar.gz"
      sha256 "a9c6aa3f76d7cfb69696a78a85c430cef1c603de2ee46877ac5aacbfb9635896"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715348647/marzano-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2e4d308eac84585eafa8a5f8ac77fa701858f96f186f456709ab164e3dfbef2c"
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
