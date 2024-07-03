class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.18.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_HBcvc7oyYe_gGml5RrfeI/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "d051b67ed78d07336dc2961f6d8c2653bfc74641d4e2bf264be237eb5e8602be"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_HBcvc7oyYe_gGml5RrfeI/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "7c429313c3391118f317cfa5c32ba2d1fea366297508f706892ae0c20180ec5c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_HBcvc7oyYe_gGml5RrfeI/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef8d4e90dab37c9d79cb94b40c07ce713aade003fc0256be9d70a7d8420ccacf"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_HBcvc7oyYe_gGml5RrfeI/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "de3aaf4a43110744d35f536d02770771f9f14be0335cb34f349ab8c24b6fd805"
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
