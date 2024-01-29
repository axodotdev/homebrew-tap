class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.8.2"
  on_macos do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.2/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "5461e40aada7e22a3b90d4afb2ac1e209594432b7dea0460360d6067be4c1667"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.2/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "ec513aaecf041ac34411cad44407e5af07b0ad59b42072557d1baf67f7d66e5a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.2/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1b1d89d2c37e3e20806b6070d1064da6f5772ae6fa75387c7ea1054663aa86ed"
    end
    on_intel do
      url "https://github.com/axodotdev/cargo-dist/releases/download/v0.8.2/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbfa46386a156655957c6e4dea19ff18c599f24511060b54026074c94de661f4"
    end
  end
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
