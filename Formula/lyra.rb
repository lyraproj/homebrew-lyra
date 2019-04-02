class Lyra < Formula
  homepage "https://github.com/lyraproj/lyra"
  url "https://github.com/lyraproj/lyra/archive/0.0.9.tar.gz"
  sha256 "f83cabad663626cad0595c24f4c3a38e78ff9e31e667cd6c15bc7409afbf1f2a"

  depends_on "go"  => :build
  depends_on "node" => :build

  def install
    system "make lyra plugins"
    bin.install "build/lyra" => "lyra"
    prefix.install Dir["build/goplugins"]
  end

  test do
    system "#{bin}/lyra", "help"
  end
end
