class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.1/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "a4ae433716ca1b9fa96f097dc8b7b1b174396cbf21345eb5049d85b332a8df4c"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0-prerelease.1/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "18df5da7799ce3a79f8e1d625fa6ec08471f0f3c8a6a8ae9b32368663e601c31"
  end
  version "0.3.0-prerelease.1"
  license "MIT OR Apache-2.0"

  def install
    bin.install "cargo-dist"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
