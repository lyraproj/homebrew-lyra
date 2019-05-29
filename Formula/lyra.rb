class Lyra < Formula
  version = "v0.5.0"
  homepage "https://github.com/lyraproj/lyra"
  url "https://github.com/lyraproj/lyra/archive/#{version}.tar.gz"
  sha256 "a4bf3edba2d920f9f5882fa15ef097e284c0d4f1b8563f105a1f88c81a488f53"

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
    sha256 "e626cb52f6248987b0bd77a24b38eccdf13e383087539a43fbdf71cca89d00ae" => :high_sierra
  end

  test do
    system "#{bin}/lyra", "help"
  end
end
