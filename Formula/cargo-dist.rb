class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.21.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_pbIbs9pDImvejI04EoJRA/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "22ec3d221c718f57b6b87d875b10deb08f9222b7d67072e8acd36246bd43a810"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_pbIbs9pDImvejI04EoJRA/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "8eaff9cd6940a5cc3931757af9d6569f3d11e8aa7e53df110d630769c7849830"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_pbIbs9pDImvejI04EoJRA/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff45f5b763bfc890150438e2eea30c210603896b474d924f1862470bb0989f49"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_pbIbs9pDImvejI04EoJRA/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11bcb8e2c41ea1a3e25d4fc1bbd18f791fab85db4f8b30a01488d4fd23ee7cb7"
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
