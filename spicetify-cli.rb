class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/khanhas/spicetify-cli"
  url "https://github.com/khanhas/spicetify-cli/archive/v2.1.0.tar.gz"
  sha256 "b88d4d875b7237f8d126ca232927ad1205e43712256341e40c8be8706af2fed0"
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
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spicetify -v")
  end
end
