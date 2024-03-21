class CargoDist < Formula
  desc "Shippable application packaging for Rust"
  version "0.12.0"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_d1ogvphwWw4uSwKB3Zsp-/cargo-dist-aarch64-apple-darwin.tar.xz"
      sha256 "df2c69ffa65f0604f3c6edd47a83574dfbac9cd4d41cbe51ea7c17d6aea1b095"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_d1ogvphwWw4uSwKB3Zsp-/cargo-dist-x86_64-apple-darwin.tar.xz"
      sha256 "14966e925de1e58e3ebbc27f1aa85befb2ca5d1c73cce2b615b606f7e8d95edd"
    end
  end
  on_linux do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_d1ogvphwWw4uSwKB3Zsp-/cargo-dist-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ea08fb860d5057857b8da748218277196da57185a262f6eb2333aa9efc92e7a"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/cargo-dist/ax_d1ogvphwWw4uSwKB3Zsp-/cargo-dist-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9595482add30b51a55c99d89791dc75d2435202677cf3615bb7a5c2af6b9f424"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "cargo-dist"
      end
    end
    on_macos do
      on_intel do
        bin.install "cargo-dist"
      end
    end
    on_linux do
      on_arm do
        bin.install "cargo-dist"
      end
    end
    on_linux do
      on_intel do
        bin.install "cargo-dist"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
