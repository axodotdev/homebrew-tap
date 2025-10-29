class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://axodotdev.github.io/cargo-dist"
  version "0.30.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.1/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "c31d06d6ab59cb35ada85d4498afcbeba5f020617f7dfe3e882d7f01155516a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.1/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "8436496a16e5c78e919e0ee0e3b138c46073fc09b5e138f5745e3119e5121a8b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.1/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4d67cf21de5d172e2688e2862ad07dd55caee8253e40f24b14d36f07fddecd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.30.1/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2348ba9c2020061a0e7e8822d4ddba50bd5dcd5ff1297e830a86a100025e8c6e"
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
