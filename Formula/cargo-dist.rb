class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://axodotdev.github.io/cargo-dist"
  version "0.33.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.33.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "7b3cbe25511de01d74c0f5fcb7909edabd379bea9cfa284d93af5a3cdfa3247c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.33.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "6a49bfb61bd86770d79c27f3d2b40c6b2e71cde940d3d31a6ccaaffc124d7a29"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.33.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9c554ab21a58ad46eb9b6710f89633ccb26bc2577cf4b0c2d18a5b826a31913e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.33.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4b3f0a5f0ebbdb798f6db649d01b32ba1518376b6f7a0502b7d92b75cc2c8293"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dist"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dist"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dist"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dist"
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
