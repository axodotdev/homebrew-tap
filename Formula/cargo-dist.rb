class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_B12MhYBvh6yB1atpkQddU/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "bbb2232631d97f26d677c3bb4d5f8122520498571af46cdb34ca5827aa32b1c0"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_B12MhYBvh6yB1atpkQddU/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "79c301c1454625d132b203009c25c60a2124b69ad56dab9da3d8987b5749d274"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_B12MhYBvh6yB1atpkQddU/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cddacbf1cfe11ec925d4a409aec539d4ed331019e51487a2c5729fafd41afd9b"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_B12MhYBvh6yB1atpkQddU/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "38036ca69606f1b782e2dc6d192c963aeb33c8f3424e11be671d8ffef09b1711"
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
