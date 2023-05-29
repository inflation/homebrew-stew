class X264Ymod < Formula
  desc "x264 with custom patches"
  homepage ""
  url "https://github.com/YamashitaRen/x264_YMod/archive/v1.0_20171224.tar.gz"
  sha256 "5ad728ccdb42d7d8b2ced432ca14aac544b16e19d8ea9897aee80e9f2e5ecfca"
  head "https://github.com/YamashitaRen/x264_YMod.git"

  depends_on "nasm" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-lto
      --enable-shared
      --enable-static
      --enable-strip
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdint.h>
      #include <x264.h>
      int main()
      {
          x264_picture_t pic;
          x264_picture_init(&pic);
          x264_picture_alloc(&pic, 1, 1, 1);
          x264_picture_clean(&pic);
          return 0;
      }
    EOS
    system ENV.cc, "-L#{lib}", "-lx264", "test.c", "-o", "test"
    system "./test"
  end
end
