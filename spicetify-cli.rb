class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/khanhas/spicetify-cli"
  url "https://github.com/khanhas/spicetify-cli/archive/v2.3.0.tar.gz"
  sha256 "8360c2609536ec59e64a093686c1135dde97244db4f3e69125f1673a806c7b0c"
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath/"dep"
    buildpath.install

    cd buildpath do
      system "go", "build", "-o", "spicetify"
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
