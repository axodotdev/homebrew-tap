class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.24.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O17u8Ye5cLOueLyVFSKU_/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "bc04a49c49f4a36b742e6d0087ba9a35ccc40873dfd2988918e39746469f2c4b"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O17u8Ye5cLOueLyVFSKU_/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "60db0a462253d9dbf6de6fd0680c49d7978f42eed0952ca2b2b43a3eed4b5108"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O17u8Ye5cLOueLyVFSKU_/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "88432327a54cfb4f7088a2066fcaacf6028f08bd84219a78aa7dcb5b8f023de2"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O17u8Ye5cLOueLyVFSKU_/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "48073c09c7bf3f768dc2489383894f88d3160358fb0f85c5851d4aeb05850cdf"
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
