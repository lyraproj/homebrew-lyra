class Lyra < Formula
  version = "v0.1.0"
  homepage "https://github.com/lyraproj/lyra"
  url "https://github.com/lyraproj/lyra/archive/#{version}.tar.gz"
  sha256 "757530ace4fae027734c09b666ae27c81bee96f0265d6f2ed98b80ea3ebcaf11"

  head "https://github.com/lyraproj/lyra.git"

  depends_on "go"  => :build
  depends_on "node" => :build

  def install
    system "make lyra plugins"
    bin.install "build/bin/lyra" => "lyra"
    prefix.install Dir["build/goplugins"]
    prefix.install Dir["workflows"]
    prefix.install Dir["types"]
    prefix.install Dir["examples"]
    prefix.install Dir["docs"]
    prefix.install "data.yaml"
  end

  bottle do
		# homebrew constructs url to fetch a bottle with:
    # "#{root_url}/#{name}-#{version}.#{tag}.bottle.#{revision}.tar.gz"
    root_url "https://github.com/lyraproj/lyra/releases/download/#{version}/"
    cellar :any_skip_relocation
    sha256 "40c6bd77db2314bebeb7f2f56dc62690f70515ae01d209bfe4f9277cf85233c3" => :high_sierra
  end

  test do
    system "#{bin}/lyra", "help"
  end
end
