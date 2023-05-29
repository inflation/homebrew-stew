class Libavif < Formula
  desc "Friendly, portable C implementation of the AV1 Image File Format"
  homepage "https://github.com/AOMediaCodec/libavif"
  url "https://github.com/AOMediaCodec/libavif/archive/v0.8.1.tar.gz"
  sha256 "27d39b69151fd090f26e10779ec79876af44876d180edda77beafa8e7e7aca26"
  head "https://github.com/AOMediaCodec/libavif.git"

  depends_on "cmake" => :build
  depends_on "nasm" => :build
  depends_on "dav1d"
  depends_on "rav1e"

  def install
    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DAVIF_CODEC_AOM=ON
      -DAVIF_CODEC_DAV1D=ON
      -DAVIF_CODEC_RAV1E=ON
      -DAVIF_BUILD_APPS=ON
    ]
    system "cmake", ".", *args
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end
end
