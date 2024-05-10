class Grit < Formula
  desc "GritQL is a query language for searching, linting, and modifying code"
  homepage "https://docs.grit.io/"
  version "0.1.0-alpha.1715352660"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715352660/marzano-aarch64-apple-darwin.tar.gz"
      sha256 "e9b55a49f28d2d812d381a32bd240705b2a65f55ccf12a4c3ce9abf7f7f77dc8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715352660/marzano-x86_64-apple-darwin.tar.gz"
      sha256 "eed39a3d909e05f108f9be97031e35e3e0aeb44504e03b270ebc88076fe56240"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715352660/marzano-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae51a0168639a633d2eb8d368457861b5cbda670d265c265823a4f3dd115d3a8"
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
