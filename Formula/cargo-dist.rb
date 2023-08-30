class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.2.0/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "601d701666ea2c4991fe4383a784294bc00c03bb149be1637b89cabf77d3dbf2"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.2.0/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "7a36612fa8500815a8f65bce94864f7aaff796d3699c9c97d8614de6913a22c2"
  end
  version "0.2.0"
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
