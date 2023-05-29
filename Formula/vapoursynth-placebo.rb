# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class VapoursynthPlacebo < Formula
  desc "Vapoursynth plugin for libplacebo"
  homepage "https://github.com/Lypheo/vs-placebo"
  url "https://github.com/Lypheo/vs-placebo.git"
  version "1.4.2"
  sha256 "9fb3c36331bbc115c8889ccc0cd0e1ace367ffa5bc7512cb1ea6c79cb7cfa75e"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "cmake" => :build

  depends_on "libplacebo"
  depends_on "vapoursynth"

  def install
    ENV["PKG_CONFIG_PATH"] += ":/opt/VulkanSDK/1.3.216.0/macOS/lib/pkgconfig"
    system "meson", "build", *std_meson_args
    system "ninja", "-C", "build"
    bin.install "build/libvs_placebo.dylib"
  end
end
