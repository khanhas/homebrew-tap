class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/khanhas/spicetify-cli"
  url "https://github.com/khanhas/spicetify-cli/archive/v2.7.2.tar.gz"
  sha256 "36abc3bb39d04794aafe58e95e31156c3375707f9bc068c2b5551f89066ff28a"
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath/"dep"
    buildpath.install

    cd buildpath do
      system "go", "build", "-ldflags", "\"-X main.version=" + version.to_s + "\"", "-o", "spicetify"
      bin.install "spicetify"
      cp_r "./globals.d.ts", bin
      cp_r "./jsHelper", bin
      cp_r "./Themes", bin
      cp_r "./Extensions", bin
      cp_r "./CustomApps", bin
      cp_r "./css-map.json", bin
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spicetify -v")
  end
end
