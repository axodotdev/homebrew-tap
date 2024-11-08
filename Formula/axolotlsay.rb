class Axolotlsay < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/axodotdev/axolotlsay"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.2/axolotlsay-aarch64-apple-darwin.tar.gz"
      sha256 "6e0bab0db9dcf66322fb154c89581024eec8012e1fa5a99c6a07ba36d9b7004b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.2/axolotlsay-x86_64-apple-darwin.tar.gz"
      sha256 "bd9958b1172be75c7633d133fdcda92b590c5b29d13d986992d614eabfd61135"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.2/axolotlsay-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d2440ffeecc370a998a70447b3c714cf5a617ed3bb108914fbf05776d972392"
    end
    if Hardware::CPU.intel?
      url "https://github.com/axodotdev/axolotlsay/releases/download/v0.3.2/axolotlsay-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "08e9a32f2387123f4a3b2233797192b94ee7b8cf714bc9bb2fd7b09a6dabfff8"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
    bin.install "axolotlsay" if OS.mac? && Hardware::CPU.arm?
    bin.install "axolotlsay" if OS.mac? && Hardware::CPU.intel?
    bin.install "axolotlsay" if OS.linux? && Hardware::CPU.arm?
    bin.install "axolotlsay" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
