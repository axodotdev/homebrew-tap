class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.27.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_2COPR6Ci7zk84ab2P9b-Z/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "9699f5f6708e030cccae77633120886e41e390d1d1e488557c91baf42ea8243e"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_2COPR6Ci7zk84ab2P9b-Z/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "01111493dffb4966f4edb1037de2e270fe2b20e6c5ddbebda672964fd84feb13"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_2COPR6Ci7zk84ab2P9b-Z/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "531fb1412c13357916b3092a59a92b0cbb2644848369f91fb8e10bb14b6322fd"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_2COPR6Ci7zk84ab2P9b-Z/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19b8aeabe15621e6d25c508d621c76c8c89b9946ab3535f4533f91e605c2d1a5"
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
