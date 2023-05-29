# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class VapoursynthNnedi3cl < Formula
  desc "Vapoursynth Plugin for NNEDI3CL"
  homepage "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL"
  url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL/archive/refs/tags/r8.tar.gz"
  sha256 "85ba921c9f714d6ad73a69d808dbb7e1cb4c29ae60d19b27e49b5096b79474c6"
  version "r8"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  
  depends_on "vapoursynth"

  def install
    vslib = lib/"vapoursynth"

    system "meson", "build", *std_meson_args, "--libdir=#{vslib}"
    system "ninja", "-C", "build", "install"
    vslib.install "build/libnnedi3cl.dylib"
  end
end
