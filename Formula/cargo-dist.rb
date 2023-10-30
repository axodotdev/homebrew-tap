class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.1/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "b4563ac8739c2402aac1023d8a97d9b2c498efd762840cf72dc5fb30925981cb"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.1/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "8c0f40e2d92b85e767167779a7315551521e9e1a0cfb92bb3c5f2f1ae77ad3f5"
  end
  version "0.4.1"
  license "MIT OR Apache-2.0"
  
  depends_on "xz"

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
