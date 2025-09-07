class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://axodotdev.github.io/cargo-dist"
  version "0.30.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "c5bc3609e5d95cec8f575a1944afdd85b6dc0822da973889b6fb2658ed9a32e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "63603c3727ddb1f202447924a9a0e2ea67d0561d3b03a96efccf93162bbfd48e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ca1d1eb3961b743bd47f0aa0bd1772986123e73d8a4bb8bf27f36f327877376"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc965a62d704032caa5ca3ebf177dc8c1c0da5c50f502ebc87f99056aa9b2770"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {
      dist: [
        "cargo-dist",
      ],
    },
    "aarch64-unknown-linux-gnu":          {
      dist: [
        "cargo-dist",
      ],
    },
    "aarch64-unknown-linux-musl-dynamic": {
      dist: [
        "cargo-dist",
      ],
    },
    "aarch64-unknown-linux-musl-static":  {
      dist: [
        "cargo-dist",
      ],
    },
    "x86_64-apple-darwin":                {
      dist: [
        "cargo-dist",
      ],
    },
    "x86_64-pc-windows-gnu":              {
      "dist.exe": [
        "cargo-dist.exe",
      ],
    },
    "x86_64-unknown-linux-gnu":           {
      dist: [
        "cargo-dist",
      ],
    },
    "x86_64-unknown-linux-musl-dynamic":  {
      dist: [
        "cargo-dist",
      ],
    },
    "x86_64-unknown-linux-musl-static":   {
      dist: [
        "cargo-dist",
      ],
    },
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
    bin.install "dist" if OS.mac? && Hardware::CPU.arm?
    bin.install "dist" if OS.mac? && Hardware::CPU.intel?
    bin.install "dist" if OS.linux? && Hardware::CPU.arm?
    bin.install "dist" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
