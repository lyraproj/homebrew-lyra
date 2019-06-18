class Lyra < Formula
  version = "v0.6.0"
  homepage "https://github.com/lyraproj/lyra"
  url "https://github.com/lyraproj/lyra/archive/#{version}.tar.gz"
  sha256 "675a08ac8e0d8a07416274543d163821fa9a6d35420a65fa9348c35dbd17cd14"

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
    sha256 "ec605df56e57ecdc46972ba053827f13cbacb4a2663e400993159d4c3623ab90" => :high_sierra
  end

  test do
    system "#{bin}/lyra", "help"
  end
end
