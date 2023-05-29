# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Jellyfin < Formula
  desc "Jellyfin is a Free Software Media System that puts you in control of managing and streaming your media"
  homepage "https://github.com/jellyfin/jellyfin"
  url "https://github.com/jellyfin/jellyfin/archive/refs/tags/v10.8.3.tar.gz"
  version "10.8.3"
  sha256 "412a6edad6f31792729b3101015075815fda7bfa68e7826b63f8c8352a33cebd"
  license "GPL-2.0"

  depends_on "ffmpeg"

  depends_on "dotnet" => :build

  resource "jellyfin-web" do
    url "https://artprodsu6weu.artifacts.visualstudio.com/Aa752b3a7-9db7-4862-a13c-768672f19bbe/7cce6c46-d610-45e3-9fb7-65a6bfd1b671/_apis/artifact/cGlwZWxpbmVhcnRpZmFjdDovL2plbGx5ZmluLXByb2plY3QvcHJvamVjdElkLzdjY2U2YzQ2LWQ2MTAtNDVlMy05ZmI3LTY1YTZiZmQxYjY3MS9idWlsZElkLzM5OTQzL2FydGlmYWN0TmFtZS9qZWxseWZpbi13ZWItcHJvZHVjdGlvbg2/content?format=zip"
    sha256 "f74af7dbde424a8d200ca27211da9432833020bb1a70498ff6bc7e8ac3d99daf"
  end

  def install
    system *%w[dotnet publish Jellyfin.Server --configuration Release --self-contained --runtime osx-arm64 --output dist/jellyfin-server/ "-p:DebugSymbols=false;DebugType=none;UseAppHost=true"]
    prefix.install "dist/jellyfin-server/"
    bin.mkdir
    system "ln", "-s", prefix/"jellyfin-server/jellyfin", bin/"jellyfin"

    resource("jellyfin-web").stage do
      system "unzip", "jellyfin-web-production.zip"
      (prefix/"jellyfin-server").install "jellyfin-web"
    end
  end
end
