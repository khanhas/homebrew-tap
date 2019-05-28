class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/khanhas/spicetify-cli"
  url "https://github.com/khanhas/spicetify-cli/archive/v0.8.1.tar.gz"
  sha256 "611c8b1c31a95ed013b4e17a6edebf9a61f54a92219a3c6dfab0493a11f45472"
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
