class Oranda < Formula
  desc "🎁 generate beautiful landing pages for your projects"
  homepage "https://opensource.axo.dev/oranda"
  if Hardware::CPU.type == :arm
    url "https://github.com/axodotdev/oranda/releases/download/v0.5.0/oranda-aarch64-apple-darwin.tar.gz"
    sha256 "1106e2c47c0bf2d9d9748c903f68e80aeefd389a6c152093f269fdd0f8c82c67"
  else
    url "https://github.com/axodotdev/oranda/releases/download/v0.5.0/oranda-x86_64-apple-darwin.tar.gz"
    sha256 "a3416ab31ebae504d1369a8269581fd858a762e0e559fd7ed3cabcf081d81331"
  end
  version "0.5.0"
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
