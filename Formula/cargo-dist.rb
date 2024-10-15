class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.23.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_yDz9fo_n8haXLAFaV4bsN/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "ba1728a1b44b9ebf04354829594f1ac02cfd906cc7beb0f56c6c21fa2bb53579"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_yDz9fo_n8haXLAFaV4bsN/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "ef98e07c0083198f21f551d16ba0256ce9919a3e782e917a9dd9ad4674edd844"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_yDz9fo_n8haXLAFaV4bsN/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65a168711a4dc4907a19a3f5ebed0f36da57b294f08b47ce58417a55e33af17c"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_yDz9fo_n8haXLAFaV4bsN/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "988b33a5ca293e26367520c4980c2757e92bff5f79a5643b902cc65060de15f0"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
    bin.install "cargo-dist" if OS.mac? && Hardware::CPU.arm?
    bin.install "cargo-dist" if OS.mac? && Hardware::CPU.intel?
    bin.install "cargo-dist" if OS.linux? && Hardware::CPU.arm?
    bin.install "cargo-dist" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
