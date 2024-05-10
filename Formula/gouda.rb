class Gouda < Formula
  desc "The server cli for grit"
  homepage "https://docs.grit.io"
  version "0.1.0-alpha.1715355039"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715355039/gouda-aarch64-apple-darwin.tar.gz"
      sha256 "ccc82b6e55911ab151156e2d22abd0ced79c9f40b38a8fcfee835d6d43603483"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715355039/gouda-x86_64-apple-darwin.tar.gz"
      sha256 "e83508a12deb2cfc4afd47c91cee05847d067a1121ba21860d73cc141f0995d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/gritql/releases/download/v0.1.0-alpha.1715355039/gouda-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "08e3aebb376f5273c87f6f51190e87afe4f60364c8cc1f6eecab2fe1346ef4ab"
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
