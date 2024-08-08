class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_IO2bK4vSoa6dpjFw4PSLx/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "2d27dd97bffebda6ab2c17ef6ac881ddf75e0547737b002d0dc4629432c334ce"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_IO2bK4vSoa6dpjFw4PSLx/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "27271d3a96e594b61cbd3cd2b514db2ea2bcfce6fe5e1e51723aaa2c7ad70690"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_IO2bK4vSoa6dpjFw4PSLx/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "27d35bf08c1be73e0cf682ed2451a788c9f4bcb81de259a5479411af219a8326"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_IO2bK4vSoa6dpjFw4PSLx/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "02b9e6a01720343066b2f52547a70f329f2f21fb3914d6287b4eb1b27f8a1e1b"
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
      bin.install "cargo-dist"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargo-dist"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cargo-dist"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargo-dist"
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
