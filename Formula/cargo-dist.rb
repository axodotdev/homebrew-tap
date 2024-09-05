class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.22.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_4YnFEh_-YFLuHcrCQghR3/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "a1a76d7c2e93af7380e00a3662c463f5c70b3e8f0e8e9be30194843ee5920cb7"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_4YnFEh_-YFLuHcrCQghR3/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "e9ccae8d88103d2e42f2b6378df7cecb9466f2d6159da38bd32f31da41b6da05"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_4YnFEh_-YFLuHcrCQghR3/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a4f8c6f6a3be621bd9af689c3f503c6a99e7615ae20b49698e0c6da13e17134"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_4YnFEh_-YFLuHcrCQghR3/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "772bd100cb51335462cee66fc336252e6b12123cde8e761c07bbc410ada43ad7"
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
    bin.install "cargo-dist" if OS.mac? && Hardware::CPU.arm?
    bin.install "cargo-dist" if OS.mac? && Hardware::CPU.intel?
    bin.install "cargo-dist" if OS.linux? && Hardware::CPU.arm?
    bin.install "cargo-dist" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
