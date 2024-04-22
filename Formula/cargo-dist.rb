class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.13.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O_EfE3yIKZTNpWtaUhlHp/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "95a41627779a3e557ca9e418bd9c2dc7eac0049aeac303dbd40f91e9a6cdad2a"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O_EfE3yIKZTNpWtaUhlHp/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "609f65b1747c273030e3237ec46f052b20b5f668cdc7b7da5f32b3dfcdeed572"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O_EfE3yIKZTNpWtaUhlHp/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a048a6f4ae17150a8f13599aa523bb8d14e4ee028c30c307311683bda1a92167"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_O_EfE3yIKZTNpWtaUhlHp/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8c4f961a67ffc61efd69e3bc45681e67d6235e7ad3a5f8072c4ce3ce3fbf0c8b"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cargo-dist"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargo-dist"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cargo-dist"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargo-dist"
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
