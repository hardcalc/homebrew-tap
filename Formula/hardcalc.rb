class Hardcalc < Formula
  desc "Universal terminal spreadsheet: vectors, matrices, tensors, typed cells and layers, stored as readable Markdown"
  homepage "https://hardcalc.org"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.3/hardcalc-aarch64-apple-darwin.tar.xz"
      sha256 "e41dc96846df19dce3167f4a2c05a62b3f4a05356478b6853348dfcf3aab8988"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.3/hardcalc-x86_64-apple-darwin.tar.xz"
      sha256 "118f5912efb474f0b868084d9f7276c5fd4ed4965b15093e742c01a2de4cb8f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.3/hardcalc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1091fc05a2d34d3057d6ccf273d3a2872cbd8da4c1460ae9a18ab7fda5721e0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.3/hardcalc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3822008d4ceb6b4b5256ff068869ee4660f50da73d0e8c0574a615203523ef4e"
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
