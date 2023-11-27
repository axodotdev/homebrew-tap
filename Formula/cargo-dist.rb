class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.5.0/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "cd49609d0e0f53154b33edb8896508270b1467ddd74ba0940595d55582ab9b81"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.5.0/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "a28d97547ab9eff8704a93a89cc3a168f748a8ae8c4fa4b088a66fff568d8085"
  end
  version "0.5.0"
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
