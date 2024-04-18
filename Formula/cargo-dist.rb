class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  homepage "https://opensource.axo.dev/cargo-dist/"
  version "0.13.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_cC6SBqKJkx0pWPAOdztH_/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "9fb0f09caab9e10c62551130af902544e0bfa46d132cb8c303fca7b7bcdb2fff"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_cC6SBqKJkx0pWPAOdztH_/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "8f2ad741da0bfee2852e5534e94d81b73609cd32d94c21991366feac4d3f521f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_cC6SBqKJkx0pWPAOdztH_/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "59b157798463a93eded2bab9e07c3d7af1ea1fc5d91b5682f62f6817d011b197"
    end
    if Hardware::CPU.intel?
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_cC6SBqKJkx0pWPAOdztH_/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b070c0a7938f8eecd4c674ea51e38840a754c793a17e25338a9a497050f507c"
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
