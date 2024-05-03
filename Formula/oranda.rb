class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  version "0.6.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_bButkitKXHuuq8Pom2BNe/oranda-aarch64-apple-darwin.tar.gz"
      sha256 "ae371adac9b609e5c1d902a3247bc9b476ee755cea8458a643d77fcce88889b8"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_bButkitKXHuuq8Pom2BNe/oranda-x86_64-apple-darwin.tar.gz"
      sha256 "c1b672fa2d22744914a44e270ba53f5a69a069dcbfd68adaa50a6fad4cf6194b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_bButkitKXHuuq8Pom2BNe/oranda-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c77b56a10eaef916045db5304e58f28ef6984c1ae434ac35739ed60ef41e948c"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_bButkitKXHuuq8Pom2BNe/oranda-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15da0fb9eae605da45edac65037d142970b9a7d94b05701e2fa6e0198fd876cc"
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
