class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  version "0.6.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_xYx-vLgTIL61Oe76VSbNv/oranda-aarch64-apple-darwin.tar.gz"
      sha256 "2ab32a7dd08dfc446604a5575a22fe807337b9ef4ea0c6a4b6af25cc03af660b"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_xYx-vLgTIL61Oe76VSbNv/oranda-x86_64-apple-darwin.tar.gz"
      sha256 "8036df08675d71da9161946f79932fed410a4f64ba7ef8e7a21ac1b84ba326ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_xYx-vLgTIL61Oe76VSbNv/oranda-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "85a1d30963d409c98edb373810131ed028b5ed204132ee69b27a219a0be945c6"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_xYx-vLgTIL61Oe76VSbNv/oranda-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8299c38d9c81930a514a3e6acea81db2e4d1489d7cccb2809a1fe1d9682483bc"
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
