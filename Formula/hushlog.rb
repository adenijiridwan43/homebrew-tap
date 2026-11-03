class Hushlog < Formula
  desc "The hushlog binary: pipe and wrap modes, byte-exact --tee, and exit-code passthrough."
  homepage "https://github.com/adenijiridwan43/Hushlog"
  version "0.1.0-alpha.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/adenijiridwan43/Hushlog/releases/download/v0.1.0-alpha.1/hushlog-aarch64-apple-darwin.tar.xz"
      sha256 "9c37a446cce8da4006d8efd2a18a882ba30191e392e434242eff31247b38839d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/adenijiridwan43/Hushlog/releases/download/v0.1.0-alpha.1/hushlog-x86_64-apple-darwin.tar.xz"
      sha256 "6f37a142bb11a4c400bc9be00d76f805293f3e2c4c7f64e90a0a64ceaabc84b9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/adenijiridwan43/Hushlog/releases/download/v0.1.0-alpha.1/hushlog-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5e4b1cd92ffcab7a09f0a9b344151f28abfc57d4e28d30ef348c72b9a0537661"
    end
    if Hardware::CPU.intel?
      url "https://github.com/adenijiridwan43/Hushlog/releases/download/v0.1.0-alpha.1/hushlog-x86_64-unknown-linux-musl.tar.xz"
      sha256 "cafb4e9521bf375044d0d920806d805f9cb348236d1ba71d1aa37b7c23d593fb"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "hushlog"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "hushlog"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "hushlog"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "hushlog"
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
