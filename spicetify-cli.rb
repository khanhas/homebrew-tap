class SpicetifyCli < Formula
  desc "Command-line tool to customize Spotify client"
  homepage "https://github.com/spicetify/spicetify-cli"
  url "https://github.com/spicetify/spicetify-cli/archive/refs/tags/v2.27.0/v2.27.0.tar.gz"
  sha256 "824ac8341f5833277a7177a7e17af7036a173e01acbc0730df619c035e0de16b"
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
