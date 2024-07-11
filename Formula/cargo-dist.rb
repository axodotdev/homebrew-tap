class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.19.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_1-APrvLhhi2VuJO2lz4pu/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "b80e5055f2cdc7edec169ccc289fc8dd311fffc8b1aae7e80d958840182ee073"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_1-APrvLhhi2VuJO2lz4pu/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "14ed13936b90f60e0569cfd615f9b172b085d264cdf92503ba9b0c0fca89d01c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_1-APrvLhhi2VuJO2lz4pu/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a87e3d2842aae270cd51053dfcc9b4f58ef0dd4baeaeda00853cb8f3b56f686"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_1-APrvLhhi2VuJO2lz4pu/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b023ead43ae21974499e58fc686c701e5952f18bbc25d080bd79116552d40188"
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
