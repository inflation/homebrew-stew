class Vapoursynth < Formula
  include Language::Python::Virtualenv

  desc "Video processing framework with simplicity in mind"
  homepage "http://www.vapoursynth.com"
  url "https://github.com/vapoursynth/vapoursynth/archive/R45.1.tar.gz"
  sha256 "4f43e5bb8c4817fdebe572d82febe4abac892918c54e1cb71aa6f6eb3677a877"
  head "https://github.com/vapoursynth/vapoursynth.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "boost" => :build
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "nasm" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "yasm" => :build

  depends_on "ffmpeg"
  depends_on "fftw"
  depends_on "imagemagick"
  depends_on "libass"
  depends_on :macos => :el_capitan # due to zimg dependency
  depends_on "python"
  depends_on "tesseract"
  depends_on "zimg"

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/f0/66/6309291b19b498b672817bd237caec787d1b18013ee659f17b1ec5844887/Cython-0.29.tar.gz"
    sha256 "94916d1ede67682638d3cc0feb10648ff14dc51fb7a7f147f4fedce78eaaea97"
  end

  resource "mvsfunc" do
    url "https://github.com/HomeOfVapourSynthEvolution/mvsfunc/archive/r8.tar.gz"
    sha256 "011a86eceb5485093d91a7c12a42bdf9f35384c6c89dc0ab92fca4481f68d373"
  end

  resource "havsfunc" do
    url "https://github.com/HomeOfVapourSynthEvolution/havsfunc/archive/r31.tar.gz"
    sha256 "caaacb4254ac4f0b653833648fb9913d7df865e32608980b52290485b9501b7d"
  end

  resource "adjust" do
    url "https://github.com/dubhater/vapoursynth-adjust/archive/v1.tar.gz"
    sha256 "f5b151ecc007ac784a360d84b6e4a8819d8e969dfdeacc5e4b1dfb2a6fda710f"
  end

  resource "nnedi3_resample" do
    url "https://github.com/mawen1250/VapourSynth-script.git"
  end

  resource "lsmashsource" do
    url "https://github.com/inflation/L-SMASH-Works.git"
  end

  resource "bilateral" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bilateral.git"
  end

  resource "nnedi3" do
    url "https://github.com/dubhater/vapoursynth-nnedi3/archive/v12.tar.gz"
    sha256 "235f43ef4aac04ef2f42a8c44c2c16b077754a3e403992df4b87c8c4b9e13aa5"
  end

  resource "fmtconv" do
    url "https://github.com/EleonoreMizo/fmtconv/archive/r20.tar.gz"
    sha256 "44f2f2be05a0265136ee1bb51bd08e5a47c6c1e856d0d045cde5a6bbd7b4350c"
  end

  resource "knlmeanscl" do
    url "https://github.com/Khanattila/KNLMeansCL.git"
  end

  resource "bm3d" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D.git"
  end

  resource "ctmf" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CTMF/archive/r4.1.tar.gz"
    sha256 "04af7fab53d868191a2ef593569abf0e8d4bf877257bbea8adfbbcf879861609"
  end

  resource "f3kdb" do
    url "https://github.com/SAPikachu/flash3kyuu_deband.git"
  end

  resource "histogram" do
    url "https://github.com/dubhater/vapoursynth-histogram/archive/v2.tar.gz"
    sha256 "17d33d98d52310e3890dd12411e9065f95e6b3249b4b8b8edd10d5e416674013"
  end

  resource "msmoosh" do
    url "https://github.com/dubhater/vapoursynth-msmoosh/archive/v1.1.tar.gz"
    sha256 "f49b4a00f141b245040ce1ffce00c79880da0118078d5c8f26d9a654fb028ddc"
  end

  resource "tcanny" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TCanny/archive/r12.tar.gz"
    sha256 "9f1a4944445ea44ad192e89faee25366bfbb781f32309393c03d2357c4ac39b5"
  end

  resource "fft3dfilter" do
    url "https://github.com/inflation/Vapoursynth-FFT3DFilter.git"
  end

  resource "delogo" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeLogo/archive/v0.4.tar.gz"
    sha256 "385a740cbaf4f4d28fb17b4929ea10fe75f4f733f54594882ef01f847acfff3d"
  end

  def install
    venv = virtualenv_create(buildpath/"cython", "python3")
    venv.pip_install "Cython"
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--with-cython=#{buildpath}/cython/bin/cython",
                          "--enable-plugins"
    system "make", "install"

    # Scripts
    resource("mvsfunc").stage do
      (lib/"python3.7/site-packages").install "mvsfunc.py"
    end
    resource("havsfunc").stage do
      (lib/"python3.7/site-packages").install "havsfunc.py"
    end
    resource("adjust").stage do
      (lib/"python3.7/site-packages").install "adjust.py"
    end
    resource("nnedi3_resample").stage do
      (lib/"python3.7/site-packages").install "nnedi3_resample.py"
    end
  end

  def post_install
    # Install Plugins
    resource("lsmashsource").stage do
      Dir.chdir("VapourSynth")
      system "./configure"
      system "make"
      (lib/"vapoursynth").install "libvslsmashsource.1.dylib"
    end
    resource("bilateral").stage do
      system "bash", "configure"
      system "make"
      (lib/"vapoursynth").install "libbilateral.dylib"
    end
    resource("nnedi3").stage do
      system "./autogen.sh"
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
      (lib/"vapoursynth").install "#{lib}/libnnedi3.dylib"
    end
    resource("fmtconv").stage do
      Dir.chdir("build/unix")
      system "./autogen.sh"
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
      (lib/"vapoursynth").install "#{lib}/libfmtconv.dylib"
    end
    resource("knlmeanscl").stage do
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libknlmeanscl.dylib"
    end
    resource("bm3d").stage do
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libbm3d.dylib"
    end
    resource("ctmf").stage do
      ENV["PKG_CONFIG_PATH"] = "#{lib}/pkgconfig:/usr/local/lib/pkgconfig"
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libctmf.dylib"
    end
    resource("f3kdb").stage do
      system "./waf", "configure"
      system "./waf", "build"
      (lib/"vapoursynth").install "build/libf3kdb.dylib"
    end
    resource("histogram").stage do
      system "./autogen.sh"
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
      (lib/"vapoursynth").install "#{lib}/libhistogram.dylib"
    end
    resource("msmoosh").stage do
      system "./autogen.sh"
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
      (lib/"vapoursynth").install "#{lib}/libmsmoosh.dylib"
    end
    resource("tcanny").stage do
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libtcanny.dylib"
    end
    resource("fft3dfilter").stage do
      system "cmake", "."
      system "make"
      (lib/"vapoursynth").install "libfft3dfilter.dylib"
    end
    resource("delogo").stage do
      system "./configure"
      system "make"
      (lib/"vapoursynth").install "libdelogo.dylib"
    end

    # Clean up .la files
    Dir.glob("#{lib}/*.la").each { |file| File.delete(file) }
  end

  test do
    py3 = Language::Python.major_minor_version "python3"
    ENV.prepend_path "PYTHONPATH", lib/"python#{py3}/site-packages"
    system "python3", "-c", "import vapoursynth"
    system bin/"vspipe", "--version"
  end
end