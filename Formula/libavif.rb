class Libavif < Formula
  desc "Friendly, portable C implementation of the AV1 Image File Format"
  homepage "https://github.com/AOMediaCodec/libavif"
  url "https://github.com/AOMediaCodec/libavif/archive/v0.8.4.tar.gz"
  sha256 "116b46a9a497c6ef178c5a20b912d8ac02f888dc8c537e40b5d16700823a9b16"
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
    system "make", "install"
  end
end
