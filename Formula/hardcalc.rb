class Hardcalc < Formula
  desc "Universal terminal spreadsheet: vectors, matrices, tensors, typed cells and layers, stored as readable Markdown"
  homepage "https://hardcalc.org"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.8/hardcalc-aarch64-apple-darwin.tar.xz"
      sha256 "c3972fb5a1340ce52088285d559f92af2e5eed4de7e832f02910b0a6be0386de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.8/hardcalc-x86_64-apple-darwin.tar.xz"
      sha256 "c96da8327e205298020e01e8f07682d566304c7983ff05d71c3ca71b92261303"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.8/hardcalc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9b8b32002b0b70eb4768de241ebdc0c263537135bb4a997c9c724494c3cb68fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.8/hardcalc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a007daf6bd58bd74036b5df6f300e00dcee07d3b3d39fa4ead021176ed5f141a"
    end
  end
  license "MIT"

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
