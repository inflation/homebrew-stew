class VapoursynthVcb < Formula
  include Language::Python::Virtualenv

  desc "Video processing framework with simplicity in mind"
  homepage "http://www.vapoursynth.com"
  url "https://github.com/vapoursynth/vapoursynth/archive/R50.tar.gz"
  sha256 "b9dc7ce904c6a3432df7491b7052bc4cf09ccf1e7a703053f8079a2267522f97"
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

  # Plugins and scripts
  resource "mvsfunc" do
    url "https://github.com/HomeOfVapourSynthEvolution/mvsfunc.git"
  end

  resource "havsfunc" do
    url "https://github.com/HomeOfVapourSynthEvolution/havsfunc.git"
  end

  resource "adjust" do
    url "https://github.com/dubhater/vapoursynth-adjust.git"
  end

  resource "nnedi3_resample" do
    url "https://github.com/mawen1250/VapourSynth-script.git"
  end

  resource "lsmashsource" do
    url "https://github.com/HolyWu/L-SMASH-Works.git"
  end

  resource "bilateral" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bilateral.git"
  end

  resource "nnedi3" do
    url "https://github.com/dubhater/vapoursynth-nnedi3.git"
  end

  resource "eedi2" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2.git"
  end

  resource "eedi3" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3.git"
  end

  resource "fmtconv" do
    url "https://github.com/EleonoreMizo/fmtconv/archive/r22.tar.gz"
  end

  resource "knlmeanscl" do
    url "https://github.com/Khanattila/KNLMeansCL.git"
  end

  resource "bm3d" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D.git"
  end

  resource "ctmf" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CTMF.git"
  end

  resource "f3kdb" do
    url "https://github.com/SAPikachu/flash3kyuu_deband.git"
  end

  resource "histogram" do
    url "https://github.com/dubhater/vapoursynth-histogram.git"
  end

  resource "msmoosh" do
    url "https://github.com/dubhater/vapoursynth-msmoosh.git"
  end

  resource "tcanny" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TCanny.git"
  end

  resource "fft3dfilter" do
    url "https://github.com/inflation/Vapoursynth-FFT3DFilter.git"
  end

  resource "delogo" do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeLogo.git"
  end

  resource "mvtools" do
    url "https://github.com/dubhater/vapoursynth-mvtools.git"
  end

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/99/36/a3dc962cc6d08749aa4b9d85af08b6e354d09c5468a3e0edc610f44c856b/Cython-0.29.17.tar.gz"
    sha256 "6361588cb1d82875bcfbad83d7dd66c442099759f895cf547995f00601f9caf2"
  end

  def install
    venv = virtualenv_create(buildpath/"cython", "python3")
    venv.pip_install "Cython"
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--with-cython=#{buildpath}/cython/bin/cython",
                          "--enable-plugins"
    system "make", "install"
  end

  def post_install
    # Install Plugins
    resource("lsmashsource").stage do
      Dir.chdir("VapourSynth")
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libvslsmashsource.dylib"
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
    resource("eedi2").stage do
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libeedi2.dylib"
    end
    resource("eedi3").stage do
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libeedi3m.dylib"
    end
    resource("fmtconv").stage do
      Dir.chdir("build/unix")
      inreplace "Makefile.am" do |s|
        s.gsub! /-latomic /, ""
      end
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
    resource("mvtools").stage do
      system "meson", "build"
      system "ninja", "-C", "build"
      (lib/"vapoursynth").install "build/libmvtools.dylib"
    end

    # Clean up .la files
    Dir.glob("#{lib}/*.la").each { |file| File.delete(file) }

    # Install scripts
    resource("mvsfunc").stage do
      (lib/"python3.8/site-packages").install "mvsfunc.py"
    end
    resource("havsfunc").stage do
      (lib/"python3.8/site-packages").install "havsfunc.py"
    end
    resource("adjust").stage do
      (lib/"python3.8/site-packages").install "adjust.py"
    end
    resource("nnedi3_resample").stage do
      (lib/"python3.8/site-packages").install "nnedi3_resample.py"
    end
  end

  test do
    py3 = Language::Python.major_minor_version "python3"
    ENV.prepend_path "PYTHONPATH", lib/"python#{py3}/site-packages"
    system "python3", "-c", "import vapoursynth"
    system bin/"vspipe", "--version"
  end
end
