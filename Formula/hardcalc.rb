class Hardcalc < Formula
  desc "Universal terminal spreadsheet: vectors, matrices, tensors, typed cells and layers, stored as readable Markdown"
  homepage "https://hardcalc.org"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.4/hardcalc-aarch64-apple-darwin.tar.xz"
      sha256 "03d22e0f2db9aa73bc28746b3a51f9430bfdbef4509d535740dbed040e34e479"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.4/hardcalc-x86_64-apple-darwin.tar.xz"
      sha256 "4dcf8ac097f3a4790eb276c2524e2394720e3bc9810ce6a28182a23470c60912"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.4/hardcalc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4aa2271fdfcfd7002382e5ea53a65468a77252d18a0f1afb42c2ca375b522b0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hardcalc/hardcalc/releases/download/v0.2.4/hardcalc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b9812d78522201d7f80f799c4e5ff790e0da5075a54db52838af371b71fa4e5b"
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
