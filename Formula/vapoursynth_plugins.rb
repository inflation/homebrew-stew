class VapoursynthPlugins < Formula
  desc "Various Plugins of VapourSynth"
  homepage "https://github.com/inflation/vapoursynth_plugins"
  license "LGPL-2.1-or-later"
  head "https://github.com/inflation/vapoursynth_plugins.git", branch: "main"

  depends_on "vapoursynth_vcb"
  depends_on "l-smash"
  depends_on "fftw"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "yasm" => :build
  depends_on "cmake" => :build
  depends_on "nasm" => :build

  def install
    # Install Plugins
    vslib = lib/"vapoursynth"

    Dir.chdir("L-SMASH-Works") do
      Dir.chdir("VapourSynth")
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libvslsmashsource.dylib"
    end
    Dir.chdir("VapourSynth-Bilateral") do
      system "./configure"
      system "make"
      vslib.install "libbilateral.dylib"
    end
    Dir.chdir("vapoursynth-nnedi3") do
      system "./autogen.sh"
      system "./configure", "--prefix=#{buildpath}"
      system "make", "install"
      vslib.install buildpath/"lib/libnnedi3.dylib"
    end
    Dir.chdir("VapourSynth-EEDI2") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libeedi2.dylib"
    end
    Dir.chdir("VapourSynth-EEDI3") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libeedi3m.dylib"
    end
    Dir.chdir("fmtconv") do
      Dir.chdir("build/unix")
      system "./autogen.sh"
      system "./configure", "--prefix=#{buildpath}"
      system "make", "install"
      vslib.install buildpath/"lib/libfmtconv.dylib"
    end
    Dir.chdir("KNLMeansCL") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libknlmeanscl.dylib"
    end
    Dir.chdir("VapourSynth-BM3D") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libbm3d.dylib"
    end
    Dir.chdir("VapourSynth-CTMF") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libctmf.dylib"
    end
    Dir.chdir("flash3kyuu_deband") do
      system "./waf", "configure"
      system "./waf", "build"
      vslib.install "build/libf3kdb.dylib"
    end
    Dir.chdir("vapoursynth-histogram") do
      system "./autogen.sh"
      system "./configure", "--prefix=#{buildpath}"
      system "make", "install"
      vslib.install buildpath/"lib/libhistogram.dylib"
    end
    Dir.chdir("vapoursynth-msmoosh") do
      system "./autogen.sh"
      system "./configure", "--prefix=#{buildpath}"
      system "make", "install"
      vslib.install buildpath/"lib/libmsmoosh.dylib"
    end
    Dir.chdir("VapourSynth-TCanny") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libtcanny.dylib"
    end
    Dir.chdir("Vapoursynth-FFT3DFilter") do
      system "cmake", "."
      system "make"
      vslib.install "libfft3dfilter.dylib"
    end
    Dir.chdir("VapourSynth-DeLogo") do
      system "./configure"
      system "make"
      vslib.install "libdelogo.dylib"
    end
    Dir.chdir("vapoursynth-mvtools") do
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libmvtools.dylib"
    end
    Dir.chdir("VapourSynth-Retinex") do 
      system "meson", "build"
      system "ninja", "-C", "build"
      vslib.install "build/libretinex.dylib"
    end

    # Install scripts
    python_lib = lib/"python3.9/site-packages"

    Dir.chdir("mvsfunc") do
      python_lib.install "mvsfunc.py"
    end
    Dir.chdir("havsfunc") do
      python_lib.install "havsfunc.py"
    end
    Dir.chdir("vapoursynth-adjust") do
      python_lib.install "adjust.py"
    end
    Dir.chdir("VapourSynth-script") do
      python_lib.install "nnedi3_resample.py"
    end
  end
end
