class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  version "0.6.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_Vu5Pz4aAI6baDUKPCU4eQ/oranda-aarch64-apple-darwin.tar.gz"
      sha256 "0c2361627b4ce922cfc6c607b1760576692ef2c2c36834c5bb61e26854ecbded"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_Vu5Pz4aAI6baDUKPCU4eQ/oranda-x86_64-apple-darwin.tar.gz"
      sha256 "8a786557aeece0bcc7e06b7be7d5ebb757cf9943a85bbcf2be2801efb1ac1611"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_Vu5Pz4aAI6baDUKPCU4eQ/oranda-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "07d1cc07964c53f674da152ef5eb5e213db7f291934440508f64c58a86a1d27a"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_Vu5Pz4aAI6baDUKPCU4eQ/oranda-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2db065e8b06253526a81595b9312b8c4468ff42f3f9fbe50a6ff21a42d3516d1"
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
      bin.install "oranda"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oranda"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oranda"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oranda"
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
