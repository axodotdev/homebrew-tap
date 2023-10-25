class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.0/cargo-dist-aarch64-apple-darwin.tar.xz"
    sha256 "7a672b9f092e5c6d625556c05e3ac273e3b4ca07d4b09257df3413fdb12d243f"
  else
    url "https://github.com/axodotdev/cargo-dist/releases/download/v0.4.0/cargo-dist-x86_64-apple-darwin.tar.xz"
    sha256 "9decf0c6f2169fe74a29f7fc469dc65ca8a79b8c5555afa6e5e542222918b6ce"
  end
  version "0.4.0"
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
