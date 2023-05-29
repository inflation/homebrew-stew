# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Libplacebo < Formula
  include Language::Python::Virtualenv

  desc "Reusable library for GPU-accelerated image/video processing primitives and shaders"
  homepage "https://code.videolan.org/videolan/libplacebo"
  url "https://code.videolan.org/videolan/libplacebo.git"
  version "4.208"
  license "LGPL-2.1"

  depends_on "meson" => :build
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python@3.10" => :build

  depends_on "little-cms2"
  depends_on "libepoxy"

  def install
    system Formula["python@3.10"].bin/"pip3", "install", "mako"

    ENV["PKG_CONFIG_PATH"] += ":/opt/VulkanSDK/1.3.216.0/macOS/lib/pkgconfig"
    system "meson", "build", *std_meson_args
    system "ninja", "-Cbuild", "install"
  end
end
