class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.3/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "8dc62666ed4a2c858cdac8ddaf1adcb95a264acc0b96ccc41bb0ca86bd7d832d"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.3/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "9d27101ac3323686ecb34bdd21c4d6379bf7023a2d27b6d28ebf91419a28ff8a"
  end
  version "0.4.3"
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
