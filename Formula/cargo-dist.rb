class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://axodotdev.github.io/cargo-dist"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.29.0/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "5b1fcd533ea75c510f5c65091385d2b9193d89068157599e0b693f8dfc89bfca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.29.0/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "ab4bc48e0f3fe45a23ea5afdaa2c2e39a8b0390a7ae2fd84658d2739de55560d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.29.0/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6cfb30c20fe3d103dec7397cba1af771599f8cdd2ceb2529db0628ee754d1ecb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.29.0/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "02fd913c54a19fa6d244a5212e2e99c8ac8bc4cb45e615dd6e2f33f4147e2db4"
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
