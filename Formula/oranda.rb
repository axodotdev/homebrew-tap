class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  version "0.6.2"
  on_macos do
    on_arm do
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_XYM-QyHzvwo-zm0daGd9e/oranda-aarch64-apple-darwin.tar.gz"
      sha256 "f05b339385b6f3e07563f8febea8cd8246e3723ceacdc45c8fd2fd159b6a7245"
    end
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_XYM-QyHzvwo-zm0daGd9e/oranda-x86_64-apple-darwin.tar.gz"
      sha256 "dcf19cd6f039fa30a2b87f36e3657e05606996d32541dcff925dcd5171473f26"
    end
  end
  on_linux do
    on_intel do
      url "https://axodotdev.artifacts.axodotdev.host/oranda/ax_XYM-QyHzvwo-zm0daGd9e/oranda-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4ba6b0923ad7c380b17872935c0b0d32ba483bbba27571cf519f38ea7e6a2bc"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "oranda"
      end
    end
    on_macos do
      on_intel do
        bin.install "oranda"
      end
    end
    on_linux do
      on_intel do
        bin.install "oranda"
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
