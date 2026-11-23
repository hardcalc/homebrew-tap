class Hardcalc < Formula
  desc "Universal terminal spreadsheet: vectors, matrices, tensors, typed cells and layers, stored as readable Markdown"
  homepage "https://hardcalc.org"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.7/hardcalc-aarch64-apple-darwin.tar.xz"
      sha256 "261bd67f5776735be0b9802e97132d8481cea0254ea44065dce6de9d308c5413"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.7/hardcalc-x86_64-apple-darwin.tar.xz"
      sha256 "7fcc9a3953f38b954a20a8263e409cb054b275554c01b4a7930f0114daeec8dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.7/hardcalc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e6b799fb5206f181300fff40be60355baf08fdd48a55d47d7d19d9a182fd2e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.7/hardcalc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21776e928ed6035624baf959d23eb3a33529002e452900a1e6c54999614310be"
    end
  end
  license "MIT"
  depends_on "typst"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "hardcalc", "hardconf"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hardcalc", "hardconf"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hardcalc", "hardconf"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hardcalc", "hardconf"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
