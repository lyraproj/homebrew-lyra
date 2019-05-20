class Lyra < Formula
  version = "v0.2.0"
  homepage "https://github.com/lyraproj/lyra"
  url "https://github.com/lyraproj/lyra/archive/#{version}.tar.gz"
  sha256 "a609a6b7d0cad669c8e3144890d7c6a9d7a47fe92d2c53d167f6f9fa82c608d6"

  head "https://github.com/lyraproj/lyra.git"

  depends_on "go"  => :build
  depends_on "node" => :build

  def install
    system "make lyra plugins"
    system "make generate"
    prefix.install Dir["build/goplugins"]
    prefix.install Dir["build/types"]
    prefix.install Dir["workflows"]
    prefix.install Dir["examples"]
    prefix.install Dir["docs"]
    prefix.install "data.yaml"
    bin.install "build/bin/lyra" => "lyra"
  end

  bottle do
		# homebrew constructs url to fetch a bottle with:
    # "#{root_url}/#{name}-#{version}.#{tag}.bottle.#{revision}.tar.gz"
    root_url "https://github.com/lyraproj/lyra/releases/download/#{version}/"
    cellar :any_skip_relocation
    sha256 "02e822933fcc14594686c0d831b90525862dd157fdbf65b0b1d0d8e5a64b45b9" => :high_sierra
  end

  test do
    system "#{bin}/lyra", "help"
  end
end
