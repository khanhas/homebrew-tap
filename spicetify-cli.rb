require "language/go"
class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/khanhas/spicetify-cli"
  url "https://github.com/khanhas/spicetify-cli/archive/v0.4.1.tar.gz"
  sha256 "29b065c3b5b1acab71977371fcb488b2f9af4d854ce1e57f9522398799894a7d"
  depends_on "go" => :build

  go_resource "github.com/go-ini/ini" do
    url "https://github.com/go-ini/ini.git"
  end

  go_resource "gopkg.in/cheggaaa/pb.v2" do
    url "https://gopkg.in/cheggaaa/pb.v2",
      :revision => "4d4459d942fa4ac4f80dcc7eed28b0fb436f894cf3611e9ab4b8cfdc5f4af29b"
  end

  go_resource "gopkg.in/mattn/go-colorable.v0" do
    url "https://gopkg.in/mattn/go-colorable.v0",
      :revision => "fbf40f3190901d2efa5e488890e127e575763572f292f90c2bc151e4d3d94277"
  end

  def install
    ENV["GOPATH"] = buildpath/"dep"
    buildpath.install
    Language::Go.stage_deps resources, buildpath/"dep"

    cd buildpath do
      system "go", "build", "-o", "spicetify"
      bin.install "spicetify"
      cp "-r", "./Extensions", bin
      cp "-r", "./Themes", bin
      cp "./globals.d.ts", biin
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spicetify -v")
  end
end
