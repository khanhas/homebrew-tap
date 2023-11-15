class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/spicetify/spicetify-cli"
  url "https://github.com/spicetify/spicetify-cli/archive/refs/tags/v2.27.1/v2.27.1.tar.gz"
  sha256 "3e41c4ac65d916fea662037a492ad63490a22255fad7397731f8fb6efcb3cf0d"
  head "https://github.com/spicetify/spicetify-cli.git", branch: "master"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    path = buildpath/"dep"
    path.install Dir["*"]
    cd path do
      system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "-o", "#{bin}/spicetify"
      bin.install [
        "css-map.json",
        "CustomApps",
        "Extensions",
        "globals.d.ts",
        "jsHelper",
        "Themes",
      ]
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spicetify", "-v")
  end
end
