class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://axodotdev.github.io/cargo-dist"
  version "0.28.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.28.1/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "f3fc37f5d30835227c0675bc7d5f16f062258a3a8af3e170b4ad728e7503bd82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.28.1/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "6c79e033947f485da4c8f6c239f17183970f77b1a8f74c6a4819c6eee07bf2a4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.28.1/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a081574ae7f5968141db6205825eaa2fdb98df3b78fc730ba726fd66c1263911"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.28.1/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d6634452167d18d8b5ec1fd57f03baa83055b7135f90eea431dfb6cac417e14"
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
