class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_mVR7oi54loWbKkB2Rpem1/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "e447dc0d973759b35a2534ba393eff518d45d5b3d57af03ec96985c0cf5a41ff"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_mVR7oi54loWbKkB2Rpem1/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "e1fe83e98ef3fc5627f4e42164c83c41d8bead6aaf4e60d8d0092f22735112d3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_mVR7oi54loWbKkB2Rpem1/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3295a696499a8b2b18eeeccae633f787fbd1a3bec2060b1c3f29330478010c49"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_mVR7oi54loWbKkB2Rpem1/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "39cb6563c88719f3df20467da34710957295f42c38eed81262fb8406e8a83f7a"
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
