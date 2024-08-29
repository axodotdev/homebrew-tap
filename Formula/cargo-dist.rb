class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.22.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_TD6oDvmtnt952JNUb75Ui/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "2edd06a991ce1e576f20b0e3859e4607edc4a7452c2035d980230838ef721fdd"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_TD6oDvmtnt952JNUb75Ui/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "9b5ef21d37f09dc4d8b46f66f35af12d411ea4dcff017711f0fb9af094f0c7e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_TD6oDvmtnt952JNUb75Ui/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "56f037c72096b39af67aed8c00b40b89340b5c034398ec7297c33c84ccc1fceb"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_TD6oDvmtnt952JNUb75Ui/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e0c3410d9a17fbb54990f40951eaa88d89c9da5b406d8e6250c75642fb3fa7af"
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
