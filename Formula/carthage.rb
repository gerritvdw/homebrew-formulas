class Carthage < Formula
  desc "Decentralized dependency manager for Cocoa"
  homepage "https://github.com/nsoperations/Carthage"
  url "https://github.com/nsoperations/Carthage.git",
      :tag      => "0.36.1+nsoperations",
      :version  => "0.36.1",
      :revision => "576cbe14f50b69fd724c80cd3a99919f280192e0",
      :shallow  => false
  head "https://github.com/nsoperations/Carthage.git", :shallow => false

  depends_on :xcode => ["10.2", :build]

  bottle do
    root_url "https://dl.bintray.com/nsoperations/bottles-formulas"
    cellar :any_skip_relocation
    sha256 "6c25e84159b679cdf6f8d5363d32a24bafdf8703d2ff4ff631adc43893b35480" => :mojave
  end

  def install
    if MacOS::Xcode.version >= "10.2" && MacOS.full_version < "10.14.4" && MacOS.version >= "10.14"
      odie "Xcode >=10.2 requires macOS >=10.14.4 to build Swift formulae."
    end

    system "make", "prefix_install", "PREFIX=#{prefix}"
    bash_completion.install "Source/Scripts/carthage-bash-completion" => "carthage"
    zsh_completion.install "Source/Scripts/carthage-zsh-completion" => "_carthage"
    fish_completion.install "Source/Scripts/carthage-fish-completion" => "carthage.fish"
  end

  test do
    system bin/"carthage", "version"
  end
end
