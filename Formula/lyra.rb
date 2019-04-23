class Lyra < Formula
  version = "0.0.9"
  homepage "https://github.com/lyraproj/lyra"
  url "https://github.com/lyraproj/lyra/archive/#{version}.tar.gz"
  sha256 "f83cabad663626cad0595c24f4c3a38e78ff9e31e667cd6c15bc7409afbf1f2a"

  head "https://github.com/lyraproj/lyra.git"

  depends_on "go"  => :build
  depends_on "node" => :build

  def install
    system "make lyra plugins"
    bin.install "build/lyra" => "lyra"
    prefix.install Dir["build/goplugins"]
    prefix.install Dir["workflows"]
    prefix.install Dir["types"]
    prefix.install Dir["examples"]
    prefix.install Dir["docs"]
  end

  bottle do
		# homebrew constructs url to fetch a bottle with:
    # "#{root_url}/#{name}-#{version}.#{tag}.bottle.#{revision}.tar.gz"
    root_url "https://github.com/lyraproj/lyra/releases/download/#{version}/"
    cellar :any_skip_relocation
    sha256 "520b51e0f4a8790ad51ca0afeacebcc08b87096fbed9d460445407b74d9bc7b3" => :high_sierra
  end

  test do
    system "#{bin}/lyra", "help"
  end
end
