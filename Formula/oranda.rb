class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.0-prerelease.1/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "53b73a82451face0e678812ec506355c54773fb12e6e94441846ababc8cc3994"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.4.0-prerelease.1/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "9a5c78fac30f433ee1689ba440368a6b0bbafcf47e3fbb5e45058bb1a74ca1de"
  end
  version "0.4.0-prerelease.1"
  license "MIT OR Apache-2.0"

  def install
    bin.install "oranda"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
