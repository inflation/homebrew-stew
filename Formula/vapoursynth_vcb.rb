class VapoursynthVcb < Formula
  desc "Video processing framework with simplicity in mind"
  homepage "http://www.vapoursynth.com"
  url "https://github.com/vapoursynth/vapoursynth/archive/R52.tar.gz"
  sha256 "4d5dc7950f4357da695d29708bc98013bc3e0bd72fc5d697f8c91ce3c4a4b2ac"
  license "LGPL-2.1-or-later"
  head "https://github.com/vapoursynth/vapoursynth.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cython" => :build
  depends_on "libtool" => :build
  depends_on "nasm" => :build
  depends_on "pkg-config" => :build

  depends_on "libass"
  depends_on "ffmpeg"
  depends_on "imagemagick"
  depends_on "python@3.9"
  depends_on "zimg"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-silent-rules",
                          "--disable-dependency-tracking",
                          "--with-cython=#{Formula["cython"].bin}/cython",
                          "--enable-plugins",
                          "--with-plugindir=#{lib}/vapoursynth"
    system "make", "install"
    %w[eedi3 miscfilters morpho removegrain vinverse vivtc].each do |filter|
      rm lib/"vapoursynth/lib#{filter}.la"
    end
  end

  test do
    xy = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    ENV.prepend_path "PYTHONPATH", lib/"python#{xy}/site-packages"
    system Formula["python@3.9"].opt_bin/"python3", "-c", "import vapoursynth"
    system bin/"vspipe", "--version"
  end
end
