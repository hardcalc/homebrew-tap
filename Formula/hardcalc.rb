class Hardcalc < Formula
  desc "Universal terminal spreadsheet: vectors, matrices, tensors, typed cells and layers, stored as readable Markdown"
  homepage "https://hardcalc.org"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.4/hardcalc-aarch64-apple-darwin.tar.xz"
      sha256 "707430ee10120c128ef254d29c5528f2b54ec75f50b4254dd6ed8f62ddba645d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.4/hardcalc-x86_64-apple-darwin.tar.xz"
      sha256 "9844cad86033c52f254a7b7dcb70a7586291e7e803b380f8918ad9e8a9a82c1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.4/hardcalc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "85f6cd164be52990c6c737e0dfddd8ff9063bb0a884c5067c56289628d209609"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.1.4/hardcalc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a13d7cdbaff73be4b694deead17f65d5758a29038d1f610b733a80a38c433b2"
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
