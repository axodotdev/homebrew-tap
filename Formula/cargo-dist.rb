class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.1/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "b076cde393055d247c4627599b3598799026022aff2a1b052da0a16860cd4d96"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.1/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "99c4ed98c6d4b2d3230befd98a13fccfccd56fe1cc2f5173afaad1474e9736f1"
  end
  version "0.3.1"
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
