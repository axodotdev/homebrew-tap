class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "d4a487dd3cba9219a8c2fb14c15c7c1cf90bfdff7bc9a11f13a7df3b8e541684"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.3.0/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "f7f59c2df235d6db48c9479bf6974dfe94127c4cfee05c715ef51db162b26136"
  end
  version "0.3.0"
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
