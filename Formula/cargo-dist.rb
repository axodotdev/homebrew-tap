class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.25.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_ocNQ8-BBo18CbYdq76w9y/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "f96ffadc9c5feef95c73dbe36c64d4174ab39bf6c08590a47c5637a0223a96f0"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_ocNQ8-BBo18CbYdq76w9y/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "291f5abff990742479d08c3595dc68f64e4d6cf8c3f9abdaac44be68a0c6f8e8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_ocNQ8-BBo18CbYdq76w9y/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bf4ce711fcb28b961d9c9f5d1b921559586904b66f03d3500d84aa1ee30e64e9"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_ocNQ8-BBo18CbYdq76w9y/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f902be680a31a254d88a1ef2067bf094f83e032dacaac03eaec766cba032b40"
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
